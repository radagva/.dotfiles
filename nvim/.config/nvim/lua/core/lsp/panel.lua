-- Floating roster of the LSP servers this config manages: status, whether
-- they have a custom after/lsp/<name>.lua, and (like Mason) an expandable
-- row showing the resolved config. Also lists servers Mason has installed
-- but that aren't wired up via vim.lsp.enable() in core/lsp, so "installed
-- but forgotten" servers don't go unnoticed.

local FALLBACK_ICON = "\u{f013}" -- nf-fa-gear, for servers without a resolvable filetype
local ns = vim.api.nvim_create_namespace("lsp_panel")

vim.api.nvim_set_hl(0, "LspPanelEnabled", { link = "DiagnosticOk", default = true })
vim.api.nvim_set_hl(0, "LspPanelDisabled", { link = "Comment", default = true })
vim.api.nvim_set_hl(0, "LspPanelMissing", { link = "DiagnosticError", default = true })

local M = {}

-- name -> bool, remembers which rows are expanded across re-renders
local expanded = {}
-- current floating window + line->{name, section} map, so key handlers know
-- which server the cursor is on
local state = { win = nil, owners = {} }

local function get_roster()
	local ok, core_lsp = pcall(require, "core.lsp")
	return ok and core_lsp.servers or {}
end

local function safe_config(name)
	local ok, cfg = pcall(function()
		return vim.lsp.config[name]
	end)
	return ok and cfg or nil
end

local function icon_for(cfg)
	local ft = cfg and cfg.filetypes and cfg.filetypes[1]
	if not ft then
		return FALLBACK_ICON, nil
	end
	local ok, icon, hl = pcall(MiniIcons.get, "filetype", ft)
	if ok and icon then
		return icon, hl
	end
	return FALLBACK_ICON, nil
end

local function is_installed(cfg)
	if not cfg or not cfg.cmd then
		return false
	end
	if type(cfg.cmd) ~= "table" then
		return true -- function cmd: can't check statically, assume it's fine
	end
	return vim.fn.executable(cfg.cmd[1]) == 1
end

local function status_of(name, cfg)
	if not is_installed(cfg) then
		return "not_installed"
	end
	if vim.lsp.is_enabled(name) then
		return "enabled"
	end
	return "disabled"
end

local function is_running(name)
	return #vim.lsp.get_clients({ name = name }) > 0
end

local DOT_HL = {
	enabled = "LspPanelEnabled",
	disabled = "LspPanelDisabled",
	not_installed = "LspPanelMissing",
}

local function custom_config_path(name)
	local matches = vim.api.nvim_get_runtime_file("after/lsp/" .. name .. ".lua", false)
	if #matches == 0 then
		return nil
	end
	return vim.fn.fnamemodify(matches[1], ":~")
end

local function lspconfig_default_source(name)
	for _, path in ipairs(vim.api.nvim_get_runtime_file("lsp/" .. name .. ".lua", true)) do
		if path:match("nvim%-lspconfig") then
			return path
		end
	end
	return nil
end

local function collect_unconfigured_mason(roster_set)
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return {}
	end

	local entries, seen = {}, {}
	for _, pkg_name in ipairs(registry.get_installed_package_names()) do
		local pkg_ok, pkg = pcall(registry.get_package, pkg_name)
		local lsp_name = pkg_ok and pkg.spec.neovim and pkg.spec.neovim.lspconfig
		if lsp_name and not roster_set[lsp_name] and not seen[lsp_name] then
			seen[lsp_name] = true
			table.insert(entries, { name = lsp_name, package = pkg_name })
		end
	end

	table.sort(entries, function(a, b)
		return a.name < b.name
	end)
	return entries
end

-- Builds one line from {text, hl} parts, returning the text and a list of
-- {col, end_col, hl} extmark specs (byte offsets, so this is safe with
-- multi-byte nerd font glyphs).
local function build_row(parts)
	local line, marks = "", {}
	for _, part in ipairs(parts) do
		local start_col = #line
		line = line .. part.text
		if part.hl then
			table.insert(marks, { col = start_col, end_col = #line, hl = part.hl })
		end
	end
	return line, marks
end

local function describe(name)
	local cfg = safe_config(name)
	if not cfg then
		return { "no default configuration found" }
	end
	local display = vim.deepcopy(cfg)
	display.name = nil
	return vim.split(vim.inspect(display), "\n")
end

local function render(win)
	local roster = get_roster()
	local roster_set = {}
	for _, name in ipairs(roster) do
		roster_set[name] = true
	end

	local lines, owners, marks = {}, {}, {}

	local function push(parts, owner)
		local text, row_marks = build_row(parts)
		table.insert(lines, text)
		if #row_marks > 0 then
			marks[#lines] = row_marks
		end
		if owner then
			owners[#lines] = owner
		end
	end

	local name_width = 0
	for _, name in ipairs(roster) do
		name_width = math.max(name_width, #name)
	end

	push({
		{ text = "  " },
		{ text = "●", hl = DOT_HL.enabled },
		{ text = " enabled   " },
		{ text = "●", hl = DOT_HL.disabled },
		{ text = " disabled   " },
		{ text = "●", hl = DOT_HL.not_installed },
		{ text = " not installed" },
	})

	local function push_server_row(name)
		local cfg = safe_config(name)
		local icon, icon_hl = icon_for(cfg)
		local status = status_of(name, cfg)
		local path = custom_config_path(name)

		local parts = {
			{ text = "  " },
			{ text = icon, hl = icon_hl },
			{ text = " " },
			{ text = name .. string.rep(" ", name_width - #name) },
			{ text = "  " },
			{ text = "●", hl = DOT_HL[status] },
		}
		if path then
			table.insert(parts, { text = "  " .. path, hl = "Comment" })
		end
		push(parts, { name = name, section = "configured" })

		if expanded[name] then
			for _, dl in ipairs(describe(name)) do
				push({ { text = "      " .. dl, hl = "Comment" } }, { name = name, section = "configured" })
			end
		end
	end

	local running, found, missing = {}, {}, {}
	for _, name in ipairs(roster) do
		if is_running(name) then
			table.insert(running, name)
		elseif is_installed(safe_config(name)) then
			table.insert(found, name)
		else
			table.insert(missing, name)
		end
	end

	local mason_entries = collect_unconfigured_mason(roster_set)

	if #running > 0 then
		push({})
		push({ { text = "  Running", hl = "Title" } })
		for _, name in ipairs(running) do
			push_server_row(name)
		end
	end

	if #found > 0 then
		push({})
		push({ { text = "  Found", hl = "Title" } })
		for _, name in ipairs(found) do
			push_server_row(name)
		end
	end

	if #missing > 0 or #mason_entries > 0 then
		push({})
		push({ { text = "  Not configured", hl = "Title" } })
		for _, name in ipairs(missing) do
			push_server_row(name)
		end
		for _, entry in ipairs(mason_entries) do
			local icon, icon_hl = icon_for(safe_config(entry.name))
			push({
				{ text = "  " },
				{ text = icon, hl = icon_hl },
				{ text = " " },
				{ text = entry.name },
				{ text = "  " },
				{ text = "(" .. entry.package .. ")", hl = "Comment" },
			}, { name = entry.name, section = "mason" })
		end
	end

	vim.bo[win.buf].modifiable = true
	vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
	vim.api.nvim_buf_clear_namespace(win.buf, ns, 0, -1)
	for line_idx, row_marks in pairs(marks) do
		for _, mark in ipairs(row_marks) do
			vim.api.nvim_buf_set_extmark(win.buf, ns, line_idx - 1, mark.col, {
				end_col = mark.end_col,
				hl_group = mark.hl,
			})
		end
	end
	vim.bo[win.buf].modifiable = false

	state.owners = owners
end

local function rerender_keeping_cursor(win)
	local line = vim.api.nvim_win_get_cursor(win.win)[1]
	local current = state.owners[line]

	render(win)

	if current then
		for idx, owner in pairs(state.owners) do
			if owner.name == current.name then
				pcall(vim.api.nvim_win_set_cursor, win.win, { idx, 0 })
				break
			end
		end
	end
end

local function current_owner(win)
	local line = vim.api.nvim_win_get_cursor(win.win)[1]
	return state.owners[line]
end

local function toggle_expand(win)
	local owner = current_owner(win)
	if not owner then
		return
	end
	expanded[owner.name] = not expanded[owner.name]
	rerender_keeping_cursor(win)
end

local function toggle_enabled(win)
	local owner = current_owner(win)
	if not owner or owner.section ~= "configured" then
		vim.notify("This server isn't configured", vim.log.levels.WARN, { title = "LSP" })
		return
	end
	vim.lsp.enable(owner.name, not vim.lsp.is_enabled(owner.name))
	rerender_keeping_cursor(win)
end

local function edit_config(win)
	local owner = current_owner(win)
	if not owner or owner.section ~= "configured" then
		vim.notify("This server isn't configured", vim.log.levels.WARN, { title = "LSP" })
		return
	end

	local name = owner.name
	local target = vim.fs.joinpath(vim.fn.stdpath("config"), "after", "lsp", name .. ".lua")

	if vim.fn.filereadable(target) == 0 then
		vim.fn.mkdir(vim.fs.dirname(target), "p")
		local default_path = lspconfig_default_source(name)
		local content = default_path and vim.fn.readfile(default_path) or { "return {}" }
		vim.fn.writefile(content, target)
	end

	win:close()
	vim.cmd.edit(target)
end

function M.open()
	if state.win and state.win:valid() then
		state.win:focus()
		return
	end

	state.win = Snacks.win({
		title = " LSP Clients ",
		style = "float",
		border = "rounded",
		backdrop = false,
		wo = { wrap = false, cursorline = true },
		keys = {
			["<CR>"] = { toggle_expand, desc = "expand/collapse" },
			["<leader>e"] = { edit_config, desc = "edit config" },
			["<leader>t"] = { toggle_enabled, desc = "toggle enabled" },
		},
		footer_keys = true,
		on_buf = function(win)
			render(win)
		end,
	})
end

return M
