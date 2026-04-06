vim.pack.add({
	{ src = "https://github.com/sainnhe/gruvbox-material" },
	{ src = "https://github.com/wtfox/jellybeans.nvim" },
	{ src = "https://github.com/echasnovski/mini.icons" },
	{ src = "https://github.com/folke/persistence.nvim", event = "BufReadPre" },
	{ src = "https://github.com/gbprod/yanky.nvim" },
	{ src = "https://github.com/rcarriga/nvim-notify" },
	{ src = "https://github.com/j-hui/fidget.nvim", name = "fidget" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/folke/todo-comments.nvim" },
})

vim.api.nvim_create_user_command("LoadLastSession", function()
	require("persistence").load()
	print("") -- clean cmdline
end, { desc = "Load last saved session in persistence" })

local yanky, notify, fidget, icons, jellybeans =
	require("yanky"), require("notify"), require("fidget"), require("mini.icons"), require("jellybeans")

icons.setup()

fidget.setup({
	notification = {
		window = {
			winblend = 0,
		},
	},
})

notify.setup({
	background_colour = "#000000",
})

vim.notify = notify

yanky.setup({
	timer = 150,
})

-- vim.g.gruvbox_material_foreground = "mix"
-- vim.g.gruvbox_material_background = "hard"
-- vim.g.gruvbox_material_ui_contrast = "high"
-- vim.g.gruvbox_material_float_style = "bright"
-- vim.g.gruvbox_material_statusline_style = "mix"
-- vim.g.gruvbox_material_cursor = "auto"
-- vim.g.gruvbox_material_transparent_background = "1"
--
-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	group = vim.api.nvim_create_augroup("custom_highlights_gruvboxmaterial", {}),
-- 	pattern = "gruvbox-material",
-- 	callback = function()
-- 		local config = vim.fn["gruvbox_material#get_configuration"]()
-- 		local palette =
-- 			vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
-- 		local set_hl = vim.fn["gruvbox_material#highlight"]
--
-- 		set_hl("WinBar", palette.none, palette.none)
-- 		set_hl("WinBarNC", palette.none, palette.none)
-- 		set_hl("StatusLine", palette.none, palette.none)
-- 		set_hl("StatusLineNC", palette.none, palette.none)
--
-- 		set_hl("PMenu", palette.none, palette.none)
-- 		set_hl("PMenuThumb", palette.none, palette.bg_visual_red)
-- 		set_hl("BlinkCmpMenuBorder", palette.none, palette.none)
-- 		--
-- 		set_hl("NormalFloat", palette.none, palette.none)
-- 		set_hl("Float", palette.none, palette.none)
-- 		set_hl("FloatBorder", palette.none, palette.none)
-- 		set_hl("FloatTitle", palette.none, palette.none)
--
-- 		set_hl("TabLineSel", palette.fg0, palette.none)
-- 		set_hl("TabLine", palette.grey0, palette.none) -- = { bg = "none", fg = c.comment }
-- 		set_hl("TabLineFill", palette.none, palette.none)
-- 		-- hl.GitSignsCurrentLineBlame = { fg = "#606079" }
-- 	end,
-- })

jellybeans.setup({
	transparent = true,
	on_highlights = function(hl)
		hl.Pmenu = { bg = "none", fg = "none" }
		hl.PmenuThumb = { bg = "#5b6078" }
		hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }
		hl.BlinkCmpMenu = { bg = "none" }
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
		hl.WhichKeyNormal = { bg = "#1F1F1F" }
		hl.WhichKeyBorder = { fg = "#1F1F1F", bg = "#1F1F1F" }
	end,
})

vim.cmd.colorscheme("jellybeans")
