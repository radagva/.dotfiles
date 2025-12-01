return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		modules = {},
		ensure_installed = {
			"lua",
			"go",
			"bash",
			"html",
			"css",
			"typescript",
			"tsx",
			"http",
			"sql",
			-- config files
			"json",
			"yaml",
			"toml",
			"c",
		},
		sync_install = false,
		auto_install = true,
		ignore_install = { "some_parser" },
		highlight = {
			enable = true,
			disable = { "help" },
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		incremental_selection = { enable = true },
		textobjects = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
