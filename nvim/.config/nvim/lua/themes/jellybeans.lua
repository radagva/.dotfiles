return {
	"wtfox/jellybeans.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		on_highlights = function(hl)
			hl.Pmenu = { bg = "none", fg = "none" }
			hl.PmenuThumb = { bg = "#5b6078" }
			hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }
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
		end,
	},
}
