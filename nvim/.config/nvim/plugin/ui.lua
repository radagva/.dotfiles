-- local ascii = require("ui.dashboard")
local gh = require("config.utils").gh

vim.pack.add({
	gh("echasnovski/mini.icons"),
	gh("j-hui/fidget.nvim", { name = "fidget" }),
	gh("folke/which-key.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
})

local fidget, icons, whichkey = require("fidget"), require("mini.icons"), require("which-key")

icons.setup()

fidget.setup({
	notification = {
		window = { winblend = 0 },
	},
})

whichkey.setup({ preset = "modern" })

vim.cmd.colorscheme("dark-2026")
