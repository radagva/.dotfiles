return {
	"rose-pine/neovim",
	name = "rose-pine",
	lazy = true,
	opts = {
		variant = "moon",
		styles = {
			transparency = true,
		},
		highlight_groups = {
			Visual = {
				bg = "#e0def4",
				fg = "#ffffff",
			},
			Pmenu = { bg = "none", fg = "none" },
			-- PmenuThumb = { bg = "#C0A36E" },
			BlinkCmpMenuBorder = { fg = "", bg = "none" },

			NormalFloat = { bg = "none" },
			Float = { bg = "none" },
			FloatBorder = { bg = "none" },
			FloatTitle = { bg = "none" },

			WinBar = { bg = "none" },
			WinBarNC = { bg = "none" },
			TabLineSel = { bg = "none", fg = "white" },
			TabLine = { bg = "none", fg = "gray" },
			TabLineFill = { bg = "none", fg = "none" },

			StatusLine = { bg = "none" },
			StatusLineNC = { bg = "none" },

			GitSignsCurrentLineBlame = { fg = "#8B91A9" },

			-- WinBar = { bg = "none" },
			-- WinBarNC = { bg = "none" },
			--
			-- TabLineSel = { bg = "none", fg = "#FFFFFF" },
			-- TabLine = { bg = "none", fg = "#CCCCCC" },
			-- TabLineFill = { bg = "none", fg = "none" },
			-- NvimDapViewTab = { bg = "none" },
			-- -- WhichKeyNormal = { bg = "#282828" },
			--
			-- -- transparent lualine
			-- StatusLine = { bg = "none" },
			-- StatusLineNC = { bg = "none" },
			-- GitSignsCurrentLineBlame = { fg = "#8B91A9" },
			--
			-- -- transparent autocompletion
			-- Pmenu = { bg = "none", fg = "none" },
		},
	},
}
