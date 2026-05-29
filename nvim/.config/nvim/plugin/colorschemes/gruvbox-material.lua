local github = require("config.utils").github

vim.pack.add({ github("sainnhe/gruvbox-material") })

vim.g.gruvbox_material_transparent_background = 1

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
	pattern = "gruvbox-material",
	callback = function()
		local config = vim.fn["gruvbox_material#get_configuration"]()
		local palette =
			vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
		local set_hl = vim.fn["gruvbox_material#highlight"]

		set_hl("WinBar", palette.none, palette.none)
		set_hl("WinBarNC", palette.none, palette.none)
		set_hl("StatusLine", palette.none, palette.none)
		set_hl("StatusLineNC", palette.none, palette.none)
		set_hl("Pmenu", palette.none, palette.none)
		set_hl("NormalFloat", palette.none, palette.none)
		set_hl("Float", palette.none, palette.none)
		set_hl("FloatTitle", palette.none, palette.none)
		set_hl("FloatBorder", palette.none, palette.none)
		-- set_hl("ErrorMsg", palette.none)
		--
		-- hl.StatusLine = { bg = "none" }
		-- hl.StatusLineNC = { bg = "none" }
		--
		-- hl.GitSignsCurrentLineBlame = { fg = "#5b6078" }
	end,
})
