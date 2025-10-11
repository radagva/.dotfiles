return {
	"vague-theme/vague.nvim",
	name = "vague",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other plugins
	opts = {
		transparent = true,
		on_highlights = function(hl, c)
			hl.Pmenu = { bg = "none", fg = "none" }
			hl.PmenuThumb = { bg = "#C0A36E" }
			hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }

			hl.NormalFloat = { bg = "none" }
			hl.Float = { bg = "none" }
			hl.FloatBorder = { bg = "none" }
			hl.FloatTitle = { bg = "none" }

			hl.WinBar = { bg = "none" }
			hl.WinBarNC = { bg = "none" }
			hl.TabLineSel = { bg = "none", fg = c.fg }
			hl.TabLine = { bg = "none", fg = c.comment }
			hl.TabLineFill = { bg = "none", fg = "none" }

			hl.StatusLine = { bg = "none" }
			hl.StatusLineNC = { bg = "none" }

			hl.GitSignsCurrentLineBlame = { fg = "#8B91A9" }
		end,
	},
}
