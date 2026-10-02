require("mini.ai").setup()

require("mini.pairs").setup()

require("mini.surround").setup({
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
