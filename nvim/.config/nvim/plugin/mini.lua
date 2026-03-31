vim.pack.add({
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/echasnovski/mini.pairs" },
	{ src = "https://github.com/echasnovski/mini.surround" },
})

local ai, pairs, surround = require("mini.ai"), require("mini.pairs"), require("mini.surround")

ai.setup()

pairs.setup()

surround.setup({
	mappings = {
		add = "gsa",
		delete = "gsd",
		find = "gsf",
		find_left = "gsF",
		highlight = "gsh",
		replace = "gsr",
		update_n_lines = "gsn",

		suffix_last = "gl",
		suffix_next = "gn",
	},
})
