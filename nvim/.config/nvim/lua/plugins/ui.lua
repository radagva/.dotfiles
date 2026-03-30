return {
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
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			icons = {
				group = "",
			},
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		keys = {
			{ "<leader>,", hidden = true },
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
