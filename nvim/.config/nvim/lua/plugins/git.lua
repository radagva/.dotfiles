return {
	{
		"lewis6991/gitsigns.nvim",
		---@diagnostic disable: missing-fields
		---@type Gitsigns.Config
		opts = {
			preview_config = {
				border = "rounded",
			},
			current_line_blame = true,
			current_line_blame_opts = {
				-- virt_text = true,
				-- virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 250,
				-- ignore_whitespace = false,
				-- virt_text_priority = 100,
				-- use_focus = true,
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
				-- map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk" })
			end,
		},
	},
	{ "tpope/vim-fugitive" },
	{
		"pwntester/octo.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"ibhagwan/fzf-lua",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			picker = "fzf-lua",
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
