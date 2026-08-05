local gh = require("config.utils").gh
local highlights = require("config.utils").highlights

vim.pack.add({ gh("wtfox/jellybeans.nvim") })

require("jellybeans").setup({
	transparent = true,
	background = {
		dark = "jellybeans", -- default dark palette
		light = "jellybeans", -- default light palette
	},
	on_highlights = function(hl, _)
		highlights(hl)
		hl.LspInlayHint = { bg = "none", fg = "#535965" }
	end,
})
