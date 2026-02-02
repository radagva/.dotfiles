local override = function()
	local hl = {}
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

	-- hl.TabLineSel = { bg = "none", fg = c.fg }
	-- hl.TabLine = { bg = "none", fg = c.comment }
	-- hl.CursorLineNr = { fg = c.func }
	-- hl["@lsp.type.class"] = hl.Number

	return hl
end
-- {  }
return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	opts = {
		flavour = "macchiato",
		transparent_background = true,
		custom_highlights = override(),
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
	end,
}
