return {
	{ "tpope/vim-fugitive" },

	{
		"lewis6991/gitsigns.nvim",
		opts = {
			preview_config = {
				border = "rounded",
			},
			current_line_blame = true,
			current_line_blame_opts = {
				delay = 250,
			},
			on_attach = function()
				local gitsigns = require("gitsigns")
				local map = vim.keymap.set

				map("n", "<leader>ggs", gitsigns.stage_hunk, { desc = "Stage hunk" })
				map("n", "<leader>ggr", gitsigns.reset_hunk, { desc = "Reset hunk" })

				map("n", "<leader>ggS", gitsigns.stage_buffer, { desc = "Stage buffer" })
				map("n", "<leader>ggR", gitsigns.reset_buffer, { desc = "Reset buffer" })
				map("n", "<leader>ggp", function()
					gitsigns.preview_hunk()
					gitsigns.preview_hunk()
				end, { desc = "Preview hunk" })
				map("n", "<leader>ggi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

				map("n", "<leader>ggb", function()
					gitsigns.blame_line({ full = true }, function()
						gitsigns.blame_line({ full = true })
					end)
				end, { desc = "Blame line" })

				map("n", "<leader>ggB", gitsigns.blame, { desc = "Blame buffer" })

				map("n", "<leader>ggd", gitsigns.diffthis, { desc = "Diff this" })
			end,
		},
	},

	{
		"pwntester/octo.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			picker = "snacks",
		},
		keys = {
			{
				"<leader>go",
				":Octo actions<CR>",
				desc = "Open Octo",
			},
		},
		config = function(_, opts)
			require("octo").setup(opts)
		end,
	},
}
