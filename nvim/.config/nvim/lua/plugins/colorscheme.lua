local transparent = true

return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "macchiato",
		transparent_background = transparent, -- disables setting the background color.
		float = {
			transparent = transparent, -- enable transparent floating windows
			solid = transparent, -- use solid styling for floating windows, see |winborder|
		},
		custom_highlights = function(colors)
			return {
				Pmenu = { bg = "none", fg = "none" },
				PmenuThumb = { bg = "#C0A36E" },
				BlinkCmpMenuBorder = { fg = "", bg = "none" },

				NormalFloat = { bg = "none" },
				Float = { bg = "none" },
				FloatBorder = { bg = "none" },
				FloatTitle = { bg = "none" },

				WinBar = { bg = "none" },
				WinBarNC = { bg = "none" },
				TabLineSel = { bg = "none", fg = colors.text },
				TabLine = { bg = "none", fg = colors.comment },
				TabLineFill = { bg = "none", fg = "none" },

				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },

				GitSignsCurrentLineBlame = { fg = colors.overlay1 },
				CursorLineNr = { fg = colors.mauve },

				SnacksTitle = { fg = colors.mauve },
				SnacksPickerTitle = { fg = colors.mauve },
			}
		end,
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
-- return {
-- 	"vague-theme/vague.nvim",
-- 	lazy = false, -- make sure we load this during startup if it is your main colorscheme
-- 	priority = 1000, -- make sure to load this before all the other plugins
-- 	opts = {
-- 		transparent = true,
-- 		on_highlights = function(hl, c)
-- 			hl.Pmenu = { bg = "none", fg = "none" }
-- 			hl.PmenuThumb = { bg = "#C0A36E" }
-- 			hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }
--
-- 			hl.NormalFloat = { bg = "none" }
-- 			hl.Float = { bg = "none" }
-- 			hl.FloatBorder = { bg = "none" }
-- 			hl.FloatTitle = { bg = "none" }
--
-- 			hl.WinBar = { bg = "none" }
-- 			hl.WinBarNC = { bg = "none" }
-- 			hl.TabLineSel = { bg = "none", fg = c.fg }
-- 			hl.TabLine = { bg = "none", fg = c.comment }
-- 			hl.TabLineFill = { bg = "none", fg = "none" }
--
-- 			hl.StatusLine = { bg = "none" }
-- 			hl.StatusLineNC = { bg = "none" }
--
-- 			hl.GitSignsCurrentLineBlame = { fg = "#606079" }
-- 			hl.CursorLineNr = { fg = c.func }
--
-- 			hl["@lsp.type.class"] = hl.Number
-- 		end,
-- 	},
--
-- 	init = function()
-- 		vim.cmd.colorscheme("vague")
-- 	end,
-- }
