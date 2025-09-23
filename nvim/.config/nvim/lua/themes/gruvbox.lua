return {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	priority = 1000,
	config = true,
	lazy = false,
	---@type GruvboxConfig
	opts = {
		contrast = "hard",
		transparent_mode = true,
		italic = {
			comments = true,
		},
		overrides = {
			-- transparent NvimDapView tabs
			TabLineSel = { bg = "none", fg = "#FFFFFF" },
			TabLine = { bg = "none", fg = "#CCCCCC" },
			TabLineFill = { bg = "none", fg = "none" },
			NvimDapViewTab = { bg = "none" },
			-- WhichKeyNormal = { bg = "#282828" },

			-- transparent lualine
			StatusLine = { bg = "none" },
			StatusLineNC = { bg = "none" },
			GitSignsCurrentLineBlame = { fg = "#918474" },

			-- transparent autocompletion
			Pmenu = { bg = "none", fg = "none" },
		},
	},
}
