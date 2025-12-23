return {
	"sainnhe/gruvbox-material",
	name = "gruvbox-material",
	config = function()
		vim.g.gruvbox_material_background = "hard"

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

				set_hl("PMenu", palette.none, palette.none)
				set_hl("PMenuThumb", palette.none, palette.bg_visual_red)
				set_hl("BlinkCmpMenuBorder", palette.none, palette.none)
				--
				set_hl("NormalFloat", palette.none, palette.none)
				set_hl("Float", palette.none, palette.none)
				set_hl("FloatBorder", palette.none, palette.none)
				set_hl("FloatTitle", palette.none, palette.none)

				set_hl("TabLineSel", palette.fg0, palette.none)
				set_hl("TabLine", palette.grey0, palette.none) -- = { bg = "none", fg = c.comment }
				set_hl("TabLineFill", palette.none, palette.none)
				-- hl.GitSignsCurrentLineBlame = { fg = "#606079" }
			end,
		})
	end,
}
