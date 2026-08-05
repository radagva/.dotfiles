local gh = require("config.utils").gh
local highlights = require("config.utils").highlights

vim.pack.add({ gh("ellisonleao/gruvbox.nvim") })

require("gruvbox").setup({
	bold = true,
	transparent_mode = true,
	contrast = "hard",
	overrides = highlights({}, {}, {
		GitSignsCurrentLineBlame = { fg = "#918374" },
		LspInlayHint = { fg = "#555049" },
		ErrorMsg = { bg = "none", fg = "#FB4834" },
	}),
})
