local github = require("config.utils").github

vim.pack.add({ github("rebelot/kanagawa.nvim") })

require("kanagawa").setup({
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
