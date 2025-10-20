local spread = require("config.utils").spread
local opts = spread({ silent = true, noremap = true })
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map({ "n" }, "<leader>`", "viw~", opts({ silent = true, desc = "Uppercase word" }))
-- Remove highlight after search by pressing Esc
map({ "n" }, "<Esc>", "<cmd>nohl<cr>", opts({ silent = true }))

-- Remove default Space action
map({ "n", "v" }, "<Space>", "<Nop>", opts({ silent = true }))

map({ "n" }, "<C-_>-", "<cmd>split | terminal<CR>a", opts({ desc = "Create new terminal in H Split" }))

map({ "n" }, "<C-_>|", "<cmd>vsplit | terminal<CR>a", opts({ desc = "Create new terminal in V Split" }))

map({ "t" }, "<C-\\>", "<C-\\><C-n><C-w>h", { silent = true })

-- save file with ctrl + s
map({ "n", "i" }, "<C-s>", "<cmd>w<CR><Esc>", opts({ expr = false }))

-- for better copying and pasting
map("n", "x", '"_x', { silent = true })
map("v", "p", '"_dP', { silent = true })
local function setup_regular_buffer_keybindings()
	local buftype = vim.bo.buftype
	if buftype == "" then -- Only regular buffers
		map({ "n" }, "dag", "ggdG", {
			desc = "[D]elete file contents",
			buffer = true,
			noremap = true,
			silent = true,
		})

		map(
			{ "n" },
			"vag",
			"ggVG",
			{ desc = "[V]isual select file contents", buffer = true, noremap = true, silent = true }
		)

		map({ "n" }, "yag", "ggyG", { desc = "[Y]ank file contents", buffer = true, noremap = true, silent = true })
	end
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = setup_regular_buffer_keybindings,
})

-- for finding and moving up and down
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "n", "nzzzv", { silent = true })
map("n", "N", "Nzzzv", { silent = true })

-- window resizing
map("n", "<Up>", ":resize -2<CR>", { silent = true })
map("n", "<Down>", ":resize +2<CR>", { silent = true })
map("n", "<Left>", ":vertical resize -2<CR>", { silent = true })
map("n", "<Right>", ":vertical resize +2<CR>", { silent = true })

-- window management
map("n", "<leader>|", "<C-w>v", { silent = false, desc = "Open new V split" })
map("n", "<leader>-", "<C-w>s", { silent = false, desc = "Open new H Split" })

-- move between buffers
map("n", "<C-h>", ":wincmd h<CR>", { silent = true })
map("n", "<C-j>", ":wincmd j<CR>", { silent = true })
map("n", "<C-k>", ":wincmd k<CR>", { silent = true })
map("n", "<C-l>", ":wincmd l<CR>", { silent = true })

-- for better indentation
map("v", "<", "<gv", { silent = true })
map("v", ">", ">gv", { silent = true })

-- buffers
map("n", "<leader>bd", ":bp|bd#<cr>", { desc = "Delete current buffer", silent = true })
map("n", "<leader>bo", function()
	local bufs = vim.api.nvim_list_bufs()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, i in ipairs(bufs) do
		if i ~= current_buf then
			vim.api.nvim_buf_delete(i, {})
		end
	end
end, { desc = "Delete all buffers but current" })
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Go to next buffer" })
map("n", "<S-h>", "<cmd>bprev<CR>", { desc = "Go to prev buffer" })

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

map("n", "<leader><Tab><Tab>", "<cmd>tabnew<cr>", opts({ desc = "New tab" }))
map("n", "<leader><Tab>x", "<cmd>tabclose<cr>", opts({ desc = "Close current tab" }))
map("n", "<leader><Tab>o", "<cmd>tabonly<cr>", opts({ desc = "Close other tabs" }))
map("n", "<leader><Tab>n", "<cmd>tabnext<cr>", opts({ desc = "Next tab" }))
map("n", "<leader><Tab>p", "<cmd>tabprevious<cr>", opts({ desc = "Prev tab" }))

-- vim.keymap.set("n", "<C-h>", function()
-- 	require("smart-splits").move_cursor_left()
-- end)
-- vim.keymap.set("n", "<C-j>", function()
-- 	require("smart-splits").move_cursor_down()
-- end)
-- vim.keymap.set("n", "<C-k>", function()
-- 	require("smart-splits").move_cursor_up()
-- end)
-- vim.keymap.set("n", "<C-l>", function()
-- 	require("smart-splits").move_cursor_right()
-- end)
-- vim.keymap.set("n", "<C-\\>", function()
-- 	require("smart-splits").move_cursor_previous()
-- end)
