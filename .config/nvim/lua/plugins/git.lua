return {
	{
		"lewis6991/gitsigns.nvim",
		---@diagnostic disable: missing-fields
		---@type Gitsigns.Config
		opts = {
			preview_config = {
				border = "rounded",
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
}
