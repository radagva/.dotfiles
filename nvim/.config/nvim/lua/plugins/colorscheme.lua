return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		---@type tokyonight.Config
		opts = {
			style = "moon",
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
			transparent = true,
			on_colors = function() end,
			on_highlights = function(highlights, color)
				-- transparent NvimDapView tabs
				-- highlights.TabLineSel = { bg = "none", fg = color.orange }
				-- highlights.TabLine = { bg = "none", fg = color.comment }
				--
				-- -- transparent lualine
				-- highlights.StatusLine = { bg = "none" }
				-- highlights.StatusLineNC = { bg = "none" }
			end,
		},
		-- init = function()
		-- 	vim.cmd.colorscheme("tokyonight")
		-- end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
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
					-- TabLineSel = { bg = "none", fg = a.text },
					-- TabLine = { bg = "none", fg = a.overlay0 },

					-- transparent lualine
					-- StatusLine = { bg = "none" },
					-- StatusLineNC = { bg = "none" },
				}
			end,
			-- custom
		},
		-- init = function()
		-- 	vim.cmd.colorscheme("catppuccin")
		-- end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = true,
		lazy = false,
		---@type GruvboxConfig
		opts = {
			contrast = "hard",
			transparent_mode = true,
			overrides = {
				-- transparent NvimDapView tabs
				TabLineSel = { bg = "none", fg = "#FFFFFF" },
				TabLine = { bg = "none", fg = "#CCCCCC" },
				TabLineFill = { bg = "none", fg = "none" },
				NvimDapViewTab = { bg = "none" },

				-- transparent lualine
				StatusLine = { bg = "none" },
				StatusLineNC = { bg = "none" },
				GitSignsCurrentLineBlame = { fg = "#918474" },

				-- transparent autocompletion
				Pmenu = { bg = "none", fg = "none" },
			},
		},
		init = function()
			vim.cmd.colorscheme("gruvbox")
		end,
	},
}
