local github = require("config.utils").github

vim.pack.add({
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
})

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
		header = {
			"⠀⠀⠀⠀⣠⣤⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣄⠀⠀⠀⠀",
			"⠀⠀⠀⠸⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣇⠀⠀⠀",
			"⢀⣤⣤⣼⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣿⣿⣿⣷⣶⣤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣤⣤⡀",
			"⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⢀⣴⡞⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣦⡀⠀⠀⠀⠀⢀⣴⣶⣿⣿⣿⣿⣿⣿⣿",
			"⠙⠿⣿⡿⠏⢿⣿⣿⣿⣿⣦⣀⠀⣴⣿⠟⣤⡿⢁⣿⢛⣿⣿⣿⣿⣿⣿⣿⣿⡈⢿⣤⡙⣿⣦⡀⢀⣰⣿⣿⣿⣿⡿⠙⢿⣿⠿⠋",
			"⠀⠀⠀⠀⠀⠀⠙⠻⣿⣿⣿⠃⠺⠛⠟⠻⠛⠓⠛⠛⠛⠛⠛⠛⠛⠛⠛⠟⠛⠟⠆⠟⠛⠚⠟⠳⠘⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⡏⠀⡀⠂⠌⠀⠌⠠⠁⠌⠠⠁⠌⠠⠁⠌⠐⡀⠡⠀⠂⠈⠐⠀⢂⠐⠀⢸⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⣀⣀⣁⣐⣈⣀⣀⣐⣀⣀⣂⣐⣀⣈⣀⣂⣀⣐⣀⣂⣁⣀⣁⣂⣀⣁⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠻⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠿⠇⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⡿⠋⠉⠛⠻⣿⣿⣿⣿⣿⣿⠟⠉⠉⠛⠿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⠁⠀⠀⠀⠀⠀⠹⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⡇⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⠀⠀⠀⠀⠀⠀⢠⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢻⣿⣦⣀⣀⣀⣠⣴⣿⡿⠿⣿⣷⣄⣀⣀⣀⣤⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣇⠀⠀⣨⣿⣿⣿⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⢰⣶⣬⣍⢙⣛⠛⠙⠋⠙⣉⡉⣭⣴⣾⡄⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ",
			"⠀  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡇⣍⡛⠿⠏⣷⣿⣿⣿⢸⣿⣿⣧⢿⠿⠟⣁⢻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀  ⠀⠀⠀⠀⠀⠀⠀⣀⣴⣿⣿⣿⡇⠾⣿⣷⣆⣤⣭⣭⣍⢨⣭⣭⣥⠐⣶⣿⡟⢸⣿⣿⣿⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⢠⣴⣾⣿⣦⣼⣿⣿⣿⣿⠟⠃⣷⣬⣙⡛⠻⠿⣿⣿⢸⣿⡿⠿⢘⣋⣥⣶⠘⠻⣿⣿⣿⣿⣷⣴⣾⣿⣶⡄⠀⠀⠀⠀",
			"⠀⠀⠀⢺⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⢻⣿⣿⣿⣷⣶⣶⣶⣶⣶⣶⣾⣿⣿⣿⡏⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠙⠛⢻⣿⣿⣿⣿⡆⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠀⠀⠀⢠⣿⣿⣿⣿⡟⠛⠋⠁⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠈⠿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠁⠀⠀⠀⠀⠀⠈⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀",
			"⠀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠛⠛⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠚⠋⠀⠀⠀⠀⠀⠀⠀⠀",
			"",
			"",
			-- "  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆        ",
			-- "   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      ",
			-- "     ⠈   ⠈⢿⣿⣟⠦⠄⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    ",
			-- "          ⣸⣿⣿⢧⠄⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄   ",
			-- "         ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀  ",
			-- "  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿  ",
			-- " ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠄  ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄  ",
			-- "⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ ",
			-- "⠙⠃   ⣼⣿⡟⠌ ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠐⣿⣿⡇ ⠛⠻⢷⣄",
			-- "     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆   ⠁",
			-- "      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⣤⣾⡿⠃    ",
			-- "⢀⣀⠀⣠⣀⣠⣾⣿⣿⡿⠛⠋⠉⠉⠉   ⠉⠉⠉⠉⠛⠻⣿⣿⣷⣄⣀⢿⡽⢻⣦",
			-- "⠻⠶⠾⠿⠿⠿⠋⠉   R A D A G V   ⠉⠻⠿⠿⠿⠿⠿⠋",
		},
		center = {
			-- { icon = "󰁯 ", desc = "Restore session", key = "s", action = "" },
		},
		vertical_center = true,
	},
})

notify.setup({ background_colour = "#000000", merge_duplicates = true })

vim.notify = notify

yanky.setup({ timer = 15 })

whichkey.setup({ preset = "modern" })

vim.cmd.colorscheme("gruvbox-material")
