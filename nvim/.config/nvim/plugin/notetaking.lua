vim.pack.add({
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim", name = "render-markdown" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/obsidian-nvim/obsidian.nvim", name = "obsidian" },
})

local markdown, obsidian = require("render-markdown"), require("obsidian")

obsidian.setup({
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
})

vim.keymap.set("n", "<leader>o", "", { desc = "Obisdian" })
vim.keymap.set("n", "<leader>os", ":Obisidian search<cr>", { desc = "Search notes" })
vim.keymap.set("n", "<leader>on", ":Obisidian new<cr>", { desc = "New note" })

markdown.setup({
	bullet = {
		right_pad = 1,
	},
	dash = {
		right_pad = 1,
	},
})
