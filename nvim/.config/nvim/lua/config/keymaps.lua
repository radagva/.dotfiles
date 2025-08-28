local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

map({ "n" }, "<Esc>", "<cmd>nohl<cr>", { silent = true })
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

map({ "n" }, "<CR>", "o<Esc>", { silent = true, noremap = true })

map(
	{ "n" },
	"<C-_>-",
	"<cmd>split | terminal<CR>a",
	{ silent = true, noremap = true, desc = "Create new terminal in H Split" }
)
map(
	{ "n" },
	"<C-_>|",
	"<cmd>vsplit | terminal<CR>a",
	{ silent = true, noremap = true, desc = "Create new terminal in V Split" }
)
map({ "t" }, "<C-\\>", "<C-\\><C-n><C-w>h", { silent = true })

-- save file with ctrl + s
map({ "n", "i" }, "<C-s>", "<cmd>w<CR><Esc>", { silent = true, noremap = true, expr = false })

-- for better copying and pasting
map("n", "x", '"_x', { silent = true })
map("v", "p", '"_dP', { silent = true })
-- map("n", "vag", "ggvG$", opts({ desc = "Copy file content", silent = false }))
-- map("n", "yag", "ggyG", opts({ desc = "Copy file content", silent = false }))
-- map("n", "dag", "ggdG", { desc = "Copy file content", silent = true, noremap = true })
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
			"<leader>vag",
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
map("n", "<leader>bd", ":bp|bd#<cr>", { desc = "Delete current buffer" })
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
