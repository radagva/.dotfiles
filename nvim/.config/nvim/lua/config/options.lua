-- colors
vim.opt.termguicolors = true

-- statuscolumn
vim.wo.number = true
vim.o.relativenumber = true
vim.opt.statuscolumn = [[%s%=%@v:relnum@%{v:relnum == 0 ? v:lnum : v:relnum}  ]]
vim.opt.fillchars = { eob = " " }

-- editor text
vim.o.clipboard = "unnamedplus"
vim.o.wrap = false
vim.o.linebreak = true
vim.o.autoindent = true
vim.o.smartcase = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = true

vim.o.list = true
vim.opt.listchars:append({
	tab = "  ",
	lead = " ",
	trail = "•",
	nbsp = "•",
})

-- splits & screen
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.cursorline = true
vim.o.hlsearch = true
vim.o.conceallevel = 2

vim.o.sessionoptions = "buffers,curdir,folds,winsize,terminal"

-- @important this is to keep the "editor"'s buffer "opened" while keeping edge buffers in-place
vim.o.splitkeep = "screen"
vim.o.laststatus = 3

-- code folding
vim.o.foldenable = true
vim.o.foldtext = ""
vim.o.foldlevel = 99
vim.o.foldcolumn = "1"

-- vim.o.winborder = "rounded"
