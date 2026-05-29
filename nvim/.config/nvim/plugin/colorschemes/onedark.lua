local github = require("config.utils").github

vim.pack.add({ github("navarasu/onedark.nvim") })

require("onedark").setup({
	style = "darker",
	transparent = true,
	code_style = {
		comments = "italic",
		keywords = "bold",
		functions = "none",
		variables = "none",
	},
	highlights = {
		NormalFloat = { bg = "none" },
		LspInlayHint = { bg = "none", fg = "#535965" },
		StatusLine = { bg = "none" },
	},
})
