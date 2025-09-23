return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		-- transparent_background = true,
		-- float = {
		-- 	transparent = true, -- enable transparent floating windows
		-- 	solid = false, -- use solid styling for floating windows, see |winborder|
		-- },
		highlight_overrides = {
			-- transparent NvimDapView tabs
			all = function()
				return {
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
				}
			end,
		},
	},
}
