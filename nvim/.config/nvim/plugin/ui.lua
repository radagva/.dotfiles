local ascii = require("ui.dashboard")
local gh = require("config.utils").gh

vim.pack.add({
	gh("nvim-neo-tree/neo-tree.nvim", { version = vim.version.range("3") }),
	gh("MunifTanjim/nui.nvim"),
	gh("echasnovski/mini.icons"),
	gh("gbprod/yanky.nvim"),
	gh("rcarriga/nvim-notify"),
	gh("j-hui/fidget.nvim", { name = "fidget" }),
	gh("nvim-lua/plenary.nvim"),
	gh("folke/todo-comments.nvim"),
	gh("nvimdev/dashboard-nvim"),
	gh("folke/which-key.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("A7Lavinraj/fyler.nvim", { name = "fyler", version = "stable" }),
	gh("hat0uma/csvview.nvim"),
})

require("csvview").setup()

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
})

-- vim.keymap.set(
-- 	"n",
-- 	"<leader>e",
-- 	":Neotree filesystem toggle left<cr>",
-- 	{ desc = "Show neo tree", silent = true, noremap = true }
-- )

local dashboard, yanky, notify, fidget, icons, whichkey =
	require("dashboard"),
	require("yanky"),
	require("notify"),
	require("fidget"),
	require("mini.icons"),
	require("which-key")

icons.setup()

fidget.setup({
	notification = {
		window = { winblend = 0 },
	},
})

dashboard.setup({
	theme = "doom",
	config = {
		header = ascii.dev,
		center = {
			{
				icon = "󰁯  ",
				desc = "Restore session                                  ",
				key = "s",
				action = "Persisted load_last",
			},
			{
				icon = "󰁯  ",
				desc = "Select other session",
				key = "o",
				action = "Persisted select",
			},
			{
				icon = "  ",
				desc = "Open dots",
				key = ".",
				action = "Snacks.picker.files({ cwd = '~/.dotfiles', hidden = true })",
			},
			{
				icon = "  ",
				desc = "Pack",
				key = "p",
				action = ":Pack",
			},
			{
				icon = "󰿅  ",
				desc = "Exit",
				key = "q",
				action = "q",
			},
		},
		vertical_center = true,
	},
})

notify.setup({ background_colour = "#000000", merge_duplicates = true })

vim.notify = notify

yanky.setup({ timer = 15 })

whichkey.setup({ preset = "modern" })

vim.cmd.colorscheme("dark-2026")
