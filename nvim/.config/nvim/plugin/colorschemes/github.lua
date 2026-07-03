local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({
	{
		src = github("projekt0n/github-nvim-theme"),
		name = "github-theme",
	},
})

local theme = require("github-theme")

theme.setup({
	options = {
		transparent = true,
	},
	groups = {
		all = highlights({}, {}, {
			StatusLine = { fg = "#8B949E" },
		}),
	},
})
