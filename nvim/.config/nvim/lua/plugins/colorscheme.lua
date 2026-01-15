local transparent = true

return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "moon",
		transparent = transparent,
		styles = {
			floats = "transparent",
			sidebars = "transparent",
		},
		on_highlights = function(highlights, colors)
			highlights.Pmenu = { bg = "none", fg = "none" }
			highlights.PmenuThumb = { bg = "#C0A36E" }
			highlights.BlinkCmpMenuBorder = { fg = "", bg = "none" }
			--
			highlights.NormalFloat = { bg = "none" }
			highlights.Float = { bg = "none" }
			highlights.FloatBorder = { bg = "none" }
			highlights.FloatTitle = { bg = "none" }

			highlights.WinBar = { bg = "none" }
			highlights.WinBarNC = { bg = "none" }
			highlights.TabLineSel = { bg = "none", fg = colors.fg }
			highlights.TabLine = { bg = "none", fg = colors.comment }
			highlights.TabLineFill = { bg = "none", fg = "none" }

			highlights.StatusLine = { bg = "none" }
			highlights.StatusLineNC = { bg = "none" }

			highlights.GitSignsCurrentLineBlame = { fg = "#606079" }
			highlights.CursorLineNr = { fg = colors.func }

			highlights["@lsp.type.class"] = highlights.Number
		end,
	},
	init = function()
		vim.cmd.colorscheme("tokyonight")
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
