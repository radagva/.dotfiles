-- Fidget-style LSP status: one language icon per attached client, colored
-- once that client is idle and greyed out (the segment's own dim fg) while
-- it has work in flight. A single spinner leads the group for as long as any
-- of them are busy, rather than one per client.

local theme = require("ui.statusline.theme")
local colors = require("utils.colors")

local SPINNER = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local SPINNER_MS = 80
local ERROR_MS = 5000 -- how long the error glyph lingers after the last window/showMessage error

local ERROR = "\u{ea87}" -- nf-cod-error
local FALLBACK_ICON = "\u{f013}" -- nf-fa-gear, for clients that don't declare filetypes

-- client_id -> { tokens = <set of in-flight progress tokens>, error_until }
local state = {}
local timer
local frame = 1

local function entry(client_id)
	local e = state[client_id]
	if not e then
		e = { tokens = {} }
		state[client_id] = e
	end
	return e
end

local function any_spinning()
	for _, e in pairs(state) do
		if next(e.tokens) then
			return true
		end
	end
	return false
end

local function tick()
	frame = (frame % #SPINNER) + 1
	pcall(vim.cmd, "redrawstatus")
	if not any_spinning() then
		timer:stop()
		timer:close()
		timer = nil
	end
end

local function ensure_timer()
	if timer then
		return
	end
	timer = vim.uv.new_timer()
	timer:start(SPINNER_MS, SPINNER_MS, vim.schedule_wrap(tick))
end

vim.api.nvim_create_autocmd("LspProgress", {
	desc = "Track per-client LSP progress for the statusline",
	callback = function(args)
		local e = entry(args.data.client_id)
		local kind = args.data.params.value.kind
		local token = args.data.params.token

		if kind == "end" then
			e.tokens[token] = nil
		else
			e.tokens[token] = true
			ensure_timer()
		end

		pcall(vim.cmd, "redrawstatus")
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Seed LSP statusline state for a newly attached client",
	callback = function(args)
		entry(args.data.client_id)
	end,
})

vim.api.nvim_create_autocmd("LspDetach", {
	desc = "Drop LSP statusline state for a detached client",
	callback = function(args)
		state[args.data.client_id] = nil
	end,
})

-- window/showMessage is how servers surface fatal-ish problems (missing
-- config, crashed subprocess, ...) outside of the progress protocol; flag the
-- client red for a while whenever one comes in at Error severity.
local forward_show_message = vim.lsp.handlers["window/showMessage"]
vim.lsp.handlers["window/showMessage"] = function(err, result, ctx, config)
	if result and result.type == vim.lsp.protocol.MessageType.Error then
		local e = entry(ctx.client_id)
		e.error_until = vim.uv.now() + ERROR_MS
		vim.defer_fn(function()
			pcall(vim.cmd, "redrawstatus")
		end, ERROR_MS)
	end
	if forward_show_message then
		forward_show_message(err, result, ctx, config)
	end
end

local function icon_for(client)
	local filetypes = client.config and client.config.filetypes
	local ft = filetypes and filetypes[1]
	if not ft then
		return FALLBACK_ICON, nil
	end

	local ok, icon, hl = pcall(MiniIcons.get, "filetype", ft)
	if ok and icon then
		return icon, hl
	end
	return FALLBACK_ICON, nil
end

return function()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end

	local icons = {}
	local busy = false

	for _, client in ipairs(clients) do
		if client.name ~= "copilot" then
			local e = entry(client.id)
			local icon, icon_hl = icon_for(client)
			local errored = e.error_until and vim.uv.now() < e.error_until
			local loading = next(e.tokens) ~= nil

			local rendered
			if errored then
				rendered = theme.accent("lsp", "error", ERROR)
			elseif loading then
				busy = true
				rendered = icon -- left plain: the segment's own dim fg reads as greyed out
			elseif icon_hl then
				rendered = colors.hl(icon_hl, icon)
			else
				rendered = icon
			end

			table.insert(icons, rendered)
		end
	end

	if #icons == 0 then
		return ""
	end

	local suffix = busy and (" " .. SPINNER[frame]) or ""
	return table.concat(icons, " ") .. suffix
end
