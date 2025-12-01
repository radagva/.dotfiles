return {
	{ "RRethy/vim-illuminate" },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"j-hui/fidget.nvim",
		lazy = false,
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
}
