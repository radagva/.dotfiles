return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
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
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,

			-- Automatically install missing parsers when entering buffer
			auto_install = true,

			-- List of parsers to ignore installing (for "all")
			ignore_install = { "some_parser" },

			highlight = {
				enable = true,
				disable = { "help" }, -- list of language that will be disabled
				additional_vim_regex_highlighting = false,
			},

			-- Other modules you might want (optional)
			indent = { enable = true },
			incremental_selection = { enable = true },
			textobjects = { enable = true },
		})
	end,
}
