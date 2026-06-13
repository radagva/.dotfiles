local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ github("navarasu/onedark.nvim") })

require("onedark").setup({
	style = "darker",
	transparent = false,
	code_style = {
		comments = "italic",
		keywords = "bold",
		functions = "none",
		variables = "none",
	},
	highglights = highlights({}),
	-- highlights = {
	-- 	NormalFloat = { bg = "none" },
	-- 	LspInlayHint = { bg = "none", fg = "#535965" },
	-- 	StatusLine = { bg = "none" },
	-- },
})
