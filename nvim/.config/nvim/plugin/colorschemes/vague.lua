local gh = require("config.utils").gh
local highlights = require("config.utils").highlights

vim.pack.add({ gh("vague-theme/vague.nvim") })

require("vague").setup({
	transparent = true,
	on_highlights = function(hl, _)
		highlights(hl, {}, { LspInlayHint = { fg = "#444555" } })
	end,
})
