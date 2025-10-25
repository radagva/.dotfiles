return {
	"rebelot/kanagawa.nvim",
	name = "kanagawa",
	lazy = true,
	opts = {
		-- theme = theme, -- Load "wave" theme
		background = { -- map the value of 'background' option to a theme
			dark = "dragon", -- try "dragon" !
			light = "lotus",
		},
		transparent = false,
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
			local scheme = colors.theme

			return {
				PmenuSel = { fg = "NONE", bg = scheme.ui.bg_p2 },
				PmenuSbar = { bg = scheme.ui.bg_m1 },
				PmenuThumb = { bg = "#C0A36E" },
				BlinkCmpMenuBorder = { fg = "", bg = "none" },

				NormalFloat = { bg = "none" },
				Float = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },
				CursorLineNr = { fg = colors.palette.dragonRed, bg = "NONE" },

				TabLineSel = { bg = "none", fg = "#FFFFFF" },
				TabLine = { bg = "none", fg = "#CCCCCC" },
				TabLineFill = { bg = "none", fg = "none" },
				NvimDapViewTab = { bg = "none" },
				-- WhichKeyNormal = { bg = "#282828" },

				-- transparent lualine
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
				GitSignsCurrentLineBlame = { fg = "#8B91A9" },

				-- transparent autocompletion
				Pmenu = { bg = "none", fg = "none" },
			}
		end,
	},
}
