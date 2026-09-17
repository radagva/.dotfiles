-- local ascii = require("ui.dashboard")
local gh = require("config.utils").gh

vim.pack.add({
	gh("echasnovski/mini.icons"),
	gh("folke/which-key.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("nvzone/showkeys"),
})

local icons, whichkey, showkeys = require("mini.icons"), require("which-key"), require("showkeys")

icons.setup()

-- fidget.setup({
-- 	notification = {
-- 		window = { winblend = 0 },
-- 	},
-- })

whichkey.setup({ preset = "modern" })

showkeys.setup({
	timeout = 1,
	maxkeys = 5,
	-- more opts
})

vim.cmd("ShowkeysToggle")

vim.cmd.colorscheme("dark-2026")
