local theme = "dragon"

return {
	{
		"rebelot/kanagawa.nvim",
		opts = {
			theme = theme,
			background = {
				dark = theme,
				light = theme,
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
				local scheme = colors.theme
				return {
					Pmenu = { fg = scheme.ui.shade0, bg = "none" }, -- add `blend = vim.o.pumblend` to enable transparency,,
					PmenuSel = { fg = "NONE", bg = scheme.ui.bg_p2 },
					PmenuSbar = { bg = scheme.ui.bg_m1 },
					PmenuThumb = { bg = "#C0A36E" },
					BlinkCmpMenuBorder = { fg = "", bg = "none" },

					NormalFloat = { bg = "none" },
					Float = { bg = "none" },
					FloatBorder = { bg = "none" },
					FloatTitle = { bg = "none" },
					NeoTreeTabActive = { bg = "none" },
					NeoTreeTabInactive = { bg = "none" },
					NeoTreeTabSeparatorActive = { fg = "#282727" },
					NeoTreeTabSeparatorInactive = { fg = "#282727" },
					CursorLineNr = { fg = colors.palette.dragonRed, bg = "NONE" },
					WinSeparator = { fg = "#282727" },
				}
			end,
		},
		init = function()
			vim.cmd.colorscheme("kanagawa")

			vim.api.nvim_set_hl(0, "WinbarSeparator", { fg = "#6c7086" })
			vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" })
			vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#f1fa8c" })
		end,
	},
}
