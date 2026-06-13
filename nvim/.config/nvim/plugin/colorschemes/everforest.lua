local github = require("config.utils").github

vim.pack.add({ { src = github("sainnhe/everforest") } })

vim.g.everforest_transparent_background = 1
vim.g.gruvbox_material_diagnostic_virtual_text = "highlighted"

vim.api.nvim_create_autocmd("ColorScheme", {
	group = vim.api.nvim_create_augroup("custom_highlights_everforest", {}),
	pattern = "everforest",
	callback = function()
		local config = vim.fn["everforest#get_configuration"]()
		local palette = vim.fn["everforest#get_palette"](config.background, config.colors_override)
		local set_hl = vim.fn["everforest#highlight"]

		set_hl("WinBar", palette.none, palette.none)
		set_hl("WinBarNC", palette.none, palette.none)
		set_hl("StatusLine", palette.none, palette.none)
		set_hl("StatusLineNC", palette.none, palette.none)
		set_hl("Pmenu", palette.none, palette.none)
		set_hl("NormalFloat", palette.none, palette.none)
		set_hl("Float", palette.none, palette.none)
		set_hl("FloatTitle", palette.none, palette.none)
		set_hl("FloatBorder", palette.none, palette.none)
		set_hl("ErrorMsg", palette.red, palette.none, "bold")
	end,
})
