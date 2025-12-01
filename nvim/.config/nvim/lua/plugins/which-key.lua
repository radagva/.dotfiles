return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	init = function()
		require("which-key").add({
			{ "<leader>c", group = "Coding" },
			{ "<leader>l", group = "Lazy" },
			{ "<leader>ll", ":Lazy<cr>", desc = "Open Lazy" },
			{ "<leader>s", group = "Search" },
			{ "<leader>b", group = "Buffers" },
			{ "<leader>d", group = "Debugging" },
			{ "<leader>t", group = "Testing" },
			{ "<leader>o", group = "Obsidian" },
			{ "<leader>g", group = "Git" },
			{ "<leader>u", group = "UI" },
			{ "<leader>x", group = "Diagnostics" },
			{ "<leader>R", group = "Kulala/HTTP" },
			{ "<leader><Tab>", group = "Tabs" },
		})
	end,
}
