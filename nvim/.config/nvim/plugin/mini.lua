local gh = require("config.utils").gh

vim.pack.add({
	gh("echasnovski/mini.ai"),
	gh("echasnovski/mini.pairs"),
	gh("echasnovski/mini.surround"),
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
