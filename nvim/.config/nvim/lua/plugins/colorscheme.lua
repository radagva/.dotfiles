return {
	"vague-theme/vague.nvim",
	name = "vague",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other plugins
	opts = {
		transparent = true,
		on_highlights = function(hl, _)
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

			return hl
		end,
	},
	init = function()
		vim.cmd.colorscheme("vague")
	end,
}
