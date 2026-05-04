vim.pack.add({
	{ src = "https://github.com/folke/flash.nvim" },
	-- { src = "https://github.com/mrjones2014/smart-splits.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
})

local flash = require("flash")
-- smartsplits.setup()

-- vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
-- vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true })
-- vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true })
-- vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true })
-- vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true })

-- { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
-- { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
-- { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
-- { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
-- { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },

-- vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left)
-- vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down)
-- vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up)
-- vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right)
-- vim.keymap.set("n", "<C-\\>", smartsplits.move_cursor_previous)

local flashmodes = { "n", "x", "o" }

vim.keymap.set(flashmodes, "s", flash.jump, { desc = "Flash", noremap = true })
vim.keymap.set(flashmodes, "S", flash.treesitter, { desc = "Flash Treesitter", noremap = true })
vim.keymap.set(flashmodes, "R", flash.remote, { desc = "Flash Remote", noremap = true })
