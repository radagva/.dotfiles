-- Breadcrumbs for the symbol under the cursor.
--
-- Document symbols are requested asynchronously and cached per buffer, keyed by
-- changedtick: the winbar redraws constantly, so the render path only walks a
-- cached tree and never talks to the LSP server.

local colors = require("utils.colors")

local M = {}

local SEPARATOR = " › "
local MAX_DEPTH = 4 -- deeper chains get collapsed behind an ellipsis
local DEBOUNCE_MS = 200

local RETRY_MS = 1000 -- servers answer with nil while they are still indexing
local PENDING_TIMEOUT_MS = 5000 -- don't let a dropped request wedge the buffer

-- bufnr -> { symbols = <tree>, tick = <changedtick>, pending = <bool>, last_try = <ms> }
local cache = {}
local timers = {}

-- winid -> last string we handed the winbar, so cursor moves only force a
-- redraw when the trail actually changed
local rendered = {}

-- lsp.SymbolKind -> the names mini.icons uses for its "lsp" category
local kinds = {
	"file",
	"module",
	"namespace",
	"package",
	"class",
	"method",
	"property",
	"field",
	"constructor",
	"enum",
	"interface",
	"function",
	"variable",
	"constant",
	"string",
	"number",
	"boolean",
	"array",
	"object",
	"key",
	"null",
	"enummember",
	"struct",
	"event",
	"operator",
	"typeparameter",
}

-- Only structural symbols earn a crumb. Servers are generous with the rest:
-- lua_ls reports every `if`/`for` block and local, which drowns the trail.
-- Filtered symbols are still descended into, so a function nested inside an
-- `if` keeps its own crumb.
local wanted_kinds = {
	[2] = true, -- module
	[3] = true, -- namespace
	[5] = true, -- class
	[6] = true, -- method
	[7] = true, -- property
	[8] = true, -- field
	[9] = true, -- constructor
	[10] = true, -- enum
	[11] = true, -- interface
	[12] = true, -- function
	[22] = true, -- enum member
	[23] = true, -- struct
	[26] = true, -- type parameter
}

local function icon_for(kind)
	local name = kinds[kind]
	if not name then
		return nil, nil
	end

	local ok, icon, hl = pcall(function()
		local i, h = MiniIcons.get("lsp", name)
		return i, h
	end)

	if ok and icon then
		return icon, hl
	end

	return nil, nil
end

local function range_of(symbol)
	return symbol.range or (symbol.location and symbol.location.range)
end

local function contains(range, line, col)
	local start_pos, end_pos = range.start, range["end"]

	if line < start_pos.line or line > end_pos.line then
		return false
	end
	if line == start_pos.line and col < start_pos.character then
		return false
	end
	if line == end_pos.line and col > end_pos.character then
		return false
	end

	return true
end

-- Walks both response shapes: DocumentSymbol (nested via `children`) and the
-- legacy flat SymbolInformation list, where enclosing symbols simply also match
local function collect(symbols, line, col, chain)
	for _, symbol in ipairs(symbols or {}) do
		local range = range_of(symbol)

		if range and contains(range, line, col) then
			if wanted_kinds[symbol.kind] then
				table.insert(chain, symbol)
			end

			if symbol.children then
				collect(symbol.children, line, col, chain)
			end
		end
	end

	return chain
end

local function refresh(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end

	local clients = vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/documentSymbol" })
	if #clients == 0 then
		cache[bufnr] = nil
		return
	end

	local entry = cache[bufnr] or {}
	cache[bufnr] = entry

	local tick = vim.b[bufnr].changedtick
	local waiting = entry.pending and vim.uv.now() - (entry.last_try or 0) < PENDING_TIMEOUT_MS

	if waiting or entry.tick == tick then
		return
	end

	entry.pending = true
	entry.last_try = vim.uv.now()

	local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

	local dispatched = clients[1]:request("textDocument/documentSymbol", params, function(err, result)
		entry.pending = false

		-- A warming-up server answers with nil; leave `tick` unset so the next
		-- render retries instead of caching the empty answer forever
		if err or not result then
			return
		end

		entry.tick = tick
		entry.symbols = result

		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(bufnr) then
				pcall(vim.cmd, "redrawstatus")
			end
		end)
	end, bufnr)

	-- The client refuses requests while it is still initializing, and then the
	-- handler above never runs
	if not dispatched then
		entry.pending = false
	end
end

local function schedule_refresh(bufnr)
	local timer = timers[bufnr]
	if timer then
		timer:stop()
	else
		timer = vim.uv.new_timer()
		timers[bufnr] = timer
	end

	timer:start(
		DEBOUNCE_MS,
		0,
		vim.schedule_wrap(function()
			refresh(bufnr)
		end)
	)
end

local function forget(bufnr)
	cache[bufnr] = nil

	local timer = timers[bufnr]
	if timer then
		timer:stop()
		timer:close()
		timers[bufnr] = nil
	end
end

function M.setup()
	local augroup = vim.api.nvim_create_augroup("WinbarSymbols", { clear = true })

	vim.api.nvim_create_autocmd({ "LspAttach", "BufEnter", "InsertLeave" }, {
		group = augroup,
		callback = function(args)
			refresh(args.buf)
		end,
	})

	vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
		group = augroup,
		callback = function(args)
			schedule_refresh(args.buf)
		end,
	})

	vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout", "LspDetach" }, {
		group = augroup,
		callback = function(args)
			forget(args.buf)
		end,
	})

	-- Moving between symbols does not always dirty the winbar on its own
	vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
		group = augroup,
		callback = function()
			local previous = rendered[vim.api.nvim_get_current_win()]

			if M.get() ~= previous then
				pcall(vim.cmd, "redrawstatus")
			end
		end,
	})

	vim.api.nvim_create_autocmd("WinClosed", {
		group = augroup,
		callback = function(args)
			rendered[tonumber(args.match)] = nil
		end,
	})
end

local function remember(value)
	rendered[vim.api.nvim_get_current_win()] = value
	return value
end

function M.get()
	local bufnr = vim.api.nvim_get_current_buf()
	local entry = cache[bufnr]

	-- Nothing cached yet: either the buffer predates setup, or the server was
	-- not ready when we last asked. Retry, throttled, since this runs on redraw
	if not entry or not entry.symbols then
		if not entry or vim.uv.now() - (entry.last_try or 0) > RETRY_MS then
			refresh(bufnr)
		end
		return remember("")
	end

	local cursor = vim.api.nvim_win_get_cursor(0)
	local chain = collect(entry.symbols, cursor[1] - 1, cursor[2], {})

	if #chain == 0 then
		return remember("")
	end

	local parts = {}
	local first = math.max(1, #chain - MAX_DEPTH + 1)

	if first > 1 then
		table.insert(parts, colors.hl(colors.highlights.comment, "…"))
	end

	for i = first, #chain do
		local symbol = chain[i]
		local icon, icon_hl = icon_for(symbol.kind)
		local name = symbol.name or "?"

		-- Parents stay dimmed so the symbol the cursor sits in reads first
		if i < #chain then
			name = colors.hl(colors.highlights.comment, name)
		end

		if icon then
			name = colors.hl(icon_hl or colors.highlights.comment, icon) .. " " .. name
		end

		table.insert(parts, name)
	end

	return remember(table.concat(parts, colors.hl(colors.highlights.comment, SEPARATOR)))
end

setmetatable(M, {
	__call = function(_, ...)
		return M.get(...)
	end,
})

return M
