vim.pack.add({
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
})

local gitsigns = require("gitsigns")

gitsigns.setup({
	preview_config = {
		border = "rounded",
	},
	current_line_blame = true,
	current_line_blame_opts = {
		delay = 250,
	},
	signs = {
		add = { text = "+" },
		delete = { text = "-" },
		change = { text = "~" },
		topdelete = { text = "-" },
		changedelete = { text = "!" },
	},
	on_attach = function()
		vim.keymap.set("n", "<leader>g", "", { desc = "Git" })
		vim.keymap.set("n", "<leader>ggs", gitsigns.stage_hunk, { desc = "Stage hunk" })
		vim.keymap.set("n", "<leader>ggr", gitsigns.reset_hunk, { desc = "Reset hunk" })

		vim.keymap.set("n", "<leader>ggS", gitsigns.stage_buffer, { desc = "Stage buffer" })
		vim.keymap.set("n", "<leader>ggR", gitsigns.reset_buffer, { desc = "Reset buffer" })
		vim.keymap.set("n", "<leader>ggp", function()
			gitsigns.preview_hunk()
			gitsigns.preview_hunk()
		end, { desc = "Preview hunk" })
		vim.keymap.set("n", "<leader>ggi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

		vim.keymap.set("n", "<leader>ggb", function()
			gitsigns.blame_line({ full = true }, function()
				gitsigns.blame_line({ full = true })
			end)
		end, { desc = "Blame line" })

		vim.keymap.set("n", "<leader>ggB", gitsigns.blame, { desc = "Blame buffer" })

		vim.keymap.set("n", "<leader>ggd", gitsigns.diffthis, { desc = "Diff this" })
	end,
})
