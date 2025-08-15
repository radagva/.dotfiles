return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		---@type CatppuccinOptions
		opts = {
			flavour = "mocha",
			transparent_background = true,
			float = {
				transparent = true,
				solid = false,
			},
			custom_highlights = function(a)
				return {
					-- transparent NvimDapView tabs
					TabLineSel = { bg = "none", fg = a.text },
					TabLine = { bg = "none", fg = a.overlay0 },

					-- transparent lualine
					StatusLine = { bg = "none" },
					StatusLineNC = { bg = "none" },
				}
			end,
			-- custom
		},
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
