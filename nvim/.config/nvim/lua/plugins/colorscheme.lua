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
					TabLineSel = { bg = "none", fg = a.text },
					TabLine = { bg = "none", fg = a.overlay0 },
				}
			end,
			-- custom
		},
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
