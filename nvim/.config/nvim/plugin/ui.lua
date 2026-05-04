vim.pack.add({
	{ src = "https://github.com/edeneast/nightfox.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/gbprod/yanky.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/j-hui/fidget.nvim", name = "fidget" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
	{ src = "https://github.com/nvimdev/dashboard-nvim" },
})

-- vim.api.nvim_create_user_command("LoadLastSession", function()
-- 	require("persistence").load()
-- 	print("") -- clean cmdline
-- end, { desc = "Load last saved session in persistence" })

local dashboard, yanky, notify, fidget, icons, kanagawa =
	require("dashboard"),
	require("yanky"),
	require("notify"),
	require("fidget"),
	require("mini.icons"),
	require("kanagawa")

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
	timer = 15,
})

-- ember.setup({
-- 	variant = "ember",
-- 	transparent = true,
-- 	-- transparent_floats = true,
-- 	on_highlights = function(hl, _)
-- 		hl.RenderMarkdownCode = { bg = "none" }
-- 	end,
-- })

kanagawa.setup({
	transparent = true,
	background = {
		light = "dragon",
		dark = "dragon",
	},
	colors = {
		theme = {
			all = {
				ui = {
					bg_gutter = "none",
				},
			},
		},
	},
	overrides = function(colors)
		return {
			NormalFloat = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },
			BlinkCmpMenu = { bg = colors.palette.dragonBlack3 },
			BlinkCmpMenuBorder = { bg = colors.palette.dragonBlack3 },
			BlinkCmpLabelDetail = { bg = colors.palette.dragonBlack3 },
			BlinkCmpMenuSelection = { bg = colors.palette.waveBlue1 },
			StatusLine = { bg = "none" },
			StatusLineLN = { bg = "none" },
		}
	end,
})

vim.cmd.colorscheme("nordfox")
