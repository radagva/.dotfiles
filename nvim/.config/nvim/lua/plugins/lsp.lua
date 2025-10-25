return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "http", "c", "css-lsp" },
			ui = {
				border = "rounded",
			},
		},
	},
	{ "neovim/nvim-lspconfig" },
}
