local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ github("edeneast/nightfox.nvim") })

require("nightfox").setup({
	options = {
		transparent = true,
		styles = {
			comments = "italic",
			keywords = "bold",
			types = "italic",
		},
	},
	groups = {
		all = highlights({
			["@function.angular"] = { fg = "#E4B287" },
		}),
	},
})
