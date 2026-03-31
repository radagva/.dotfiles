vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/mrjones2014/smart-splits.nvim" },
})

local flash, smartsplits = require("flash"), require("smart-splits")

smartsplits.setup()

vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left)
vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down)
vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up)
vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right)
vim.keymap.set("n", "<C-\\>", smartsplits.move_cursor_previous)

local flashmodes = { "n", "x", "o" }

vim.keymap.set(flashmodes, "s", flash.treesitter, { desc = "Flash", noremap = true })
vim.keymap.set(flashmodes, "S", flash.treesitter, { desc = "Flash Treesitter", noremap = true })
vim.keymap.set(flashmodes, "R", flash.treesitter, { desc = "Flash Remote", noremap = true })
