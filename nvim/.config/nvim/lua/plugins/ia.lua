return {
	{
		"zbirenbaum/copilot.lua",
		dependencies = {
			"copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
		},
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
	},
	{
		"giuxtaposition/blink-cmp-copilot",
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "folke/which-key.nvim" },
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			-- See Configuration section for options
		},
		init = function()
			require("which-key").add({
				{ "<leader>ai", group = "AI", mode = { "n", "v" } },
				{ "<leader>aic", group = "Copilot", mode = { "n", "v" } },
				{ "<leader>aicc", ":CopilotChat<cr>", desc = "Copilot chat", silent = true },
				{
					"<leader>aice",
					":CopilotChatExplain<cr>",
					mode = "v",
					desc = "Copilot explain selection",
					silent = true,
				},
				{ "<leader>aicf", ":CopilotChatFix<cr>", mode = "v", desc = "Copilot fix selection", silent = true },
				{ "<leader>aicr", ":CopilotChatReview<cr>", mode = "v", desc = "Copilot review", silent = true },
				{ "<leader>aico", ":CopilotChatOptimize<cr>", mode = "v", desc = "Copilot optimize", silent = true },
				{ "<leader>aicd", ":CopilotChatDocs<cr>", mode = "v", desc = "Copilot generate docs", silent = true },
				{ "<leader>aict", ":CopilotChatTest<cr>", mode = "v", desc = "Copilot generate tests", silent = true },
			})

			-- local wk = require("which-key")
			-- wk.register({
			--   c = {
			--     name = "Copilot",
			--     c = { "<cmd>CopilotChat<cr>", "Chat" },
			--   },
		end,
	},
}
