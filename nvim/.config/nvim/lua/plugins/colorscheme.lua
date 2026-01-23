-- local transparent = true
--
local highlight_groups = {}
highlight_groups.Pmenu = { bg = "none", fg = "none" }
highlight_groups.PmenuThumb = { bg = "#C0A36E" }
highlight_groups.BlinkCmpMenuBorder = { fg = "", bg = "none" }

highlight_groups.NormalFloat = { bg = "none" }
highlight_groups.Float = { bg = "none" }
highlight_groups.FloatBorder = { bg = "none" }
highlight_groups.FloatTitle = { bg = "none" }

highlight_groups.WinBar = { bg = "none", fg = "none" }
highlight_groups.WinBarNC = { bg = "none", fg = "none" }
-- highlight_groups.TabLineSel = { bg = "none", fg = "love" }
-- highlight_groups.TabLine = { bg = "none", fg = "comment" }
highlight_groups.TabLineFill = { bg = "none", fg = "none" }

highlight_groups.StatusLine = { bg = "none" }
highlight_groups.StatusLineNC = { bg = "none" }

highlight_groups.GitSignsCurrentLineBlame = { fg = "#606079" }
-- highlight_groups.CursorLineNr = { fg = "love" }

return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	config = true,
	opts = {
		contrast = "hard",
		overrides = highlight_groups,
		transparent_mode = true,
	},
	init = function()
		vim.cmd.colorscheme("gruvbox")
	end,
}
