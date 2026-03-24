-- local ipaddress = require("ui.statusline.ipaddress")
local git = require("ui.statusline.git")
local mode = require("ui.statusline.mode")
local dap = require("ui.statusline.dap")
local diagnostics = require("ui.statusline.diagnostics")
-- local lsps = require("ui.statusline.attachedlsps")
local filepath = require("ui.winbar.filepath")
-- local filetypeicon = require("ui.statusline.filetypeicon")

Statusline = {}

function Statusline.activate()
	return ""
		.. table.concat({
			mode(),
			git(),
			filepath(),
			diagnostics(),
			-- vim.fn.expand("%"),
			-- "%=",
			"%=",
			dap(),
			"%l:%c",
			-- filetypeicon(),
			-- lsps(),
			-- filetype(),
			-- ipaddress(),
		}, " ")
		.. ""
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
