local merge = require("config.utils").merge

local override = function(base, overriding)
	local hl = base or {}
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

	return merge(hl, overriding or {})
	-- return hl
end

local M = {
	"folke/tokyonight.nvim",
	name = "tokyonight",
	lazy = false,
	priority = 1000,
	opts = {
		transparent = true,
		styles = {
			sidebars = "transparent",
			floats = "transparent",
		},
		on_highlights = function(hl, _colors)
			return override(hl, {})
		end,
	},
	-- "catppuccin/nvim",
	-- name = "catppuccin",
	-- lazy = false,
	-- priority = 1000,
	-- opts = {
	-- 	flavour = "mocha",
	-- 	transparent_background = true,
	-- 	custom_highlights = override({}, {}),
	-- },
}

M.init = function()
	vim.cmd.colorscheme("tokyonight")
end

return M
