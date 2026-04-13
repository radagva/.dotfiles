vim.pack.add({
	{ src = "https://github.com/ember-theme/nvim" },
	{ src = "https://github.com/wtfox/jellybeans.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/folke/persistence.nvim", event = "BufReadPre" },
	{ src = "https://github.com/gbprod/yanky.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/j-hui/fidget.nvim", name = "fidget" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/nvimdev/dashboard-nvim" },
})

vim.api.nvim_create_user_command("LoadLastSession", function()
	require("persistence").load()
	print("") -- clean cmdline
end, { desc = "Load last saved session in persistence" })

local dashboard, yanky, notify, fidget, icons, jellybeans, ember =
	require("dashboard"),
	require("yanky"),
	require("notify"),
	require("fidget"),
	require("mini.icons"),
	require("jellybeans"),
	require("ember")

icons.setup()

fidget.setup({
	notification = {
		window = {
			winblend = 0,
		},
	},
})

dashboard.setup({
	theme = "doom",
	config = {
		header = {
			"  ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣭⣿⣶⣿⣦⣼⣆        ",
			"   ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦      ",
			"     ⠈   ⠈⢿⣿⣟⠦⠄⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄    ",
			"          ⣸⣿⣿⢧⠄⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄   ",
			"         ⢠⣿⣿⣿⠈  ⠡⠌⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀  ",
			"  ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿  ",
			" ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷⠄  ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄  ",
			"⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄ ",
			"⠙⠃   ⣼⣿⡟⠌ ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⠐⣿⣿⡇ ⠛⠻⢷⣄",
			"     ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆   ⠁",
			"      ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣀⣤⣾⡿⠃    ",
			"⢀⣀⠀⣠⣀⣠⣾⣿⣿⡿⠛⠋⠉⠉⠉   ⠉⠉⠉⠉⠛⠻⣿⣿⣷⣄⣀⢿⡽⢻⣦",
			"⠻⠶⠾⠿⠿⠿⠋⠉   R A D A G V   ⠉⠻⠿⠿⠿⠿⠿⠋",
		},
		center = {
			{ icon = "󰁯 ", desc = "Restore session", key = "s", action = "" },
		},
		vertical_center = true,
	},
})

notify.setup({
	background_colour = "#000000",
})

vim.notify = notify

yanky.setup({
	timer = 150,
})

jellybeans.setup({
	transparent = true,
	-- background = {
	-- 	dark = "jellybeans-muted",
	-- 	light = "jellybeans-muted",
	-- },
	on_highlights = function(hl)
		hl.Pmenu = { bg = "none", fg = "none" }
		hl.PmenuThumb = { bg = "#5b6078" }
		hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }
		hl.BlinkCmpMenu = { bg = "none" }
		hl.NormalFloat = { bg = "none" }
		hl.Float = { bg = "none" }
		hl.FloatBorder = { bg = "none" }
		hl.FloatTitle = { bg = "none" }
		hl.WinBar = { bg = "none" }
		hl.WinBarNC = { bg = "none" }
		hl.TabLineFill = { bg = "none", fg = "none" }
		hl.StatusLine = { bg = "none" }
		hl.StatusLineNC = { bg = "none" }
		hl.GitSignsCurrentLineBlame = { fg = "#5b6078" }
		hl.WhichKeyNormal = { bg = "#1F1F1F" }
		hl.WhichKeyBorder = { fg = "#1F1F1F", bg = "#1F1F1F" }
	end,
})

ember.setup({
	variant = "ember",
})

vim.cmd.colorscheme("ember")
