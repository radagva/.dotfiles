local spread = require("config.utils").spread
local map = vim.keymap.set
local opts = spread({ noremap = true, silent = true })

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map({ "n" }, "<Esc>", "<cmd>nohl<cr>", { silent = true })
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map({ "n" }, "<CR>", "o<Esc>", { silent = true, noremap = true })

map({ "n" }, "<C-_>", "<cmd>split | terminal<CR>a", { silent = true, noremap = true })

-- save file with ctrl + s
map({ "n", "i" }, "<C-s>", "<cmd>w<CR><Esc>", opts({}))

-- for better copying and pasting
map("n", "x", '"_x', opts({}))
map("v", "p", '"_dP', opts({}))
-- map("n", "vag", "ggvG$", opts({ desc = "Copy file content", silent = false }))
-- map("n", "yag", "ggyG", opts({ desc = "Copy file content", silent = false }))
map("n", "dag", "ggdG", opts({ desc = "Copy file content", silent = false }))

-- for finding and moving up and down
map("n", "<C-d>", "<C-d>zz", opts({}))
map("n", "<C-u>", "<C-u>zz", opts({}))
map("n", "n", "nzzzv", opts({}))
map("n", "N", "Nzzzv", opts({}))

-- window resizing
map("n", "<Up>", ":resize -2<CR>", opts({}))
map("n", "<Down>", ":resize +2<CR>", opts({}))
map("n", "<Left>", ":vertical resize -2<CR>", opts({}))
map("n", "<Right>", ":vertical resize +2<CR>", opts({}))

-- window management
map("n", "<leader>|", "<C-w>v", opts({ silent = false, desc = "Open new V split" }))
map("n", "<leader>-", "<C-w>s", opts({ silent = false, desc = "Open new H Split" }))

-- move between buffers
map("n", "<C-h>", ":wincmd h<CR>", opts({}))
map("n", "<C-j>", ":wincmd j<CR>", opts({}))
map("n", "<C-k>", ":wincmd k<CR>", opts({}))
map("n", "<C-l>", ":wincmd l<CR>", opts({}))

-- for better indentation
map("v", "<", "<gv", opts({}))
map("v", ">", ">gv", opts({}))

-- buffers
map("n", "<leader>bd", ":bp|bd#<cr>", opts({ desc = "Delete current buffer" }))
map("n", "<leader>bo", function()
	local bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, i in ipairs(bufs) do
		if i ~= current_buf then
			vim.api.nvim_buf_delete(i, {})
		end
	end
end, opts({ desc = "Delete all buffers but current" }))
map("n", "<S-l>", "<cmd>bnext<CR>", opts({ desc = "Go to next buffer" }))
map("n", "<S-h>", "<cmd>bprev<CR>", opts({ desc = "Go to prev buffer" }))

-- utils
map("n", "<leader>uip", function()
	local handle = io.popen("ipconfig getifaddr en0")
	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		output = output:gsub("%s+$", "")
		vim.notify(output, vim.log.levels.INFO, {
			title = "Router IP Address:",
		})
	end
end, { desc = "Get router IP Address" })
