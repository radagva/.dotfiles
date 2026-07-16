-- Composes the statusline: which components appear, and on which side.
-- Colors live in `theme`, separator shapes in `render`.

local theme = require("ui.statusline.theme")
local render = require("ui.statusline.render")
local mode_mod = require("ui.statusline.mode")
local git_mod = require("ui.statusline.git")
local diag_mod = require("ui.statusline.diagnostics")
local dap_mod = require("ui.statusline.dap")
local ip_mod = require("ui.statusline.ipaddress")

Statusline = {}

local function push(segs, style, content)
	if content ~= "" then
		table.insert(segs, { style = style, content = content })
	end
end

function Statusline.activate()
	local left, right = {}, {}

	push(left, theme.mode(vim.api.nvim_get_mode().mode), mode_mod())
	push(left, theme.segment("git"), git_mod())
	push(left, theme.segment("diag"), diag_mod())

	push(right, theme.segment("dap"), dap_mod())
	push(right, theme.segment("lc"), "%l:%c")
	push(right, theme.segment("lc"), ip_mod())

	return render.left(left, true) .. render.gap() .. render.right(right, true)
end

function Statusline.deactivate()
	return ""
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.activate()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.deactivate()"
	end,
})
