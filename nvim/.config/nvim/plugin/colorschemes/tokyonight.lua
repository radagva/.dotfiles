local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ { src = github("folke/tokyonight.nvim") } })

require("tokyonight").setup({
	on_highlights = highlights,
	style = "night",
	transparent = true,
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		sidebars = "transparent", -- style for sidebars, see below
		floats = "transparent", -- style for floating windows
	},
})
