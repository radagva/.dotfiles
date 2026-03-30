return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
		opts = {
			bullet = {
				right_pad = 1,
			},
			dash = {
				right_pad = 1,
			},
		},
	},
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = false,
		ft = "markdown",
		dependencies = {
			"ibhagwan/fzf-lua",
			"nvim-lua/plenary.nvim",
		},
		opts = {
			legacy_commands = false,
			note_id_func = function(title)
				if title == nil then
					return nil
				end

				-- Keep the title as-is
				return title
			end,
			workspaces = {
				{
					name = "notes",
					path = "~/Documents/Obsidian Vault",
				},
			},
			completion = {
				nvim_cmp = false,
				blink = true,
				min_chars = 2,
				create_new = true,
			},
			picker = {
				name = "snacks.pick",
				-- name = "fzf-lua",
				note_mappings = {
					new = "<C-x>",
					insert_link = "<C-l>",
				},
			},
			checkbox = {
				order = { " ", "x" },
			},
			open_notes_in = "vsplit",
			callbacks = {
				-- enter_note = function(_, note)
				-- 	vim.keymap.set("n", "<leader>ch", function()
				-- 		return require("obsidian").util.toggle_checkbox()
				-- 	end, { buffer = note.bufnr, desc = "Toggle checkbox" })
				--
				-- 	vim.keymap.set("n", "<cr>", function()
				-- 		return require("obsidian").util.smart_action()
				-- 	end, { buffer = note.bufnr, expr = true, desc = "Obsidian smart action" })
				-- end,
			},
		},
		init = function()
			local map = vim.keymap.set

			map("n", "<leader>o", "", { desc = "Obisdian" })
			map("n", "<leader>os", ":Obisidian search<cr>", { desc = "Search notes" })
			map("n", "<leader>on", ":Obisidian new<cr>", { desc = "New note" })
		end,
	},
}
