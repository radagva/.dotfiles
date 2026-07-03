local ascii = require("ui.dashboard")
local github = require("config.utils").github

vim.pack.add({
	{
		src = github("nvim-neo-tree/neo-tree.nvim"),
		version = vim.version.range("3"),
	},
	{ src = github("MunifTanjim/nui.nvim") },
	{ src = github("echasnovski/mini.icons") },
	{ src = github("gbprod/yanky.nvim") },
	{ src = github("rcarriga/nvim-notify") },
	{ src = github("j-hui/fidget.nvim"), name = "fidget" },
	{ src = github("nvim-lua/plenary.nvim") },
	{ src = github("folke/todo-comments.nvim") },
	{ src = github("nvimdev/dashboard-nvim") },
	{ src = github("folke/which-key.nvim") },
	{ src = github("nvim-tree/nvim-web-devicons") },
	{ src = github("fgheng/winbar.nvim") },
	{ src = github("A7Lavinraj/fyler.nvim"), name = "fyler", version = "stable" },
	{ src = github("hat0uma/csvview.nvim") },
})

require("csvview").setup()

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
})

vim.keymap.set(
	"n",
	"<leader>e",
	":Neotree filesystem toggle left<cr>",
	{ desc = "Show neo tree", silent = true, noremap = true }
)

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
		header = ascii.semicolon,
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

vim.cmd.colorscheme("vague")
