return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		lazy = false,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/which-key.nvim",
		},
		opts = {
			legacy_commands = false,
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
				name = "fzf-lua",
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
				enter_note = function(_, note)
					vim.keymap.set("n", "<leader>ch", function()
						return require("obsidian").util.toggle_checkbox()
					end, { buffer = note.bufnr, desc = "Toggle checkbox" })

					vim.keymap.set("n", "<cr>", function()
						return require("obsidian").util.smart_action()
					end, { buffer = note.bufnr, expr = true, desc = "Obsidian smart action" })
				end,
			},
		},
		keys = {
			{ "<leader>os", ":Obsidian search<cr>", desc = "[O]bsidian [S]earch", silent = true },
			{ "<leader>on", ":Obsidian new<cr>", desc = "[O]bsidian [N]ew", silent = true },
		},
	},
}
