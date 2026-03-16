-- colors
vim.opt.termguicolors = true
vim.opt.showmode = false

-- statuscolumn
vim.wo.number = true
vim.o.relativenumber = true
vim.opt.statuscolumn = [[%s%=%@v:relnum@%{v:relnum == 0 ? v:lnum : v:relnum}  ]]
vim.opt.fillchars = { eob = " " }

-- editor text
vim.opt.clipboard = "unnamedplus"
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.inccommand = "split"

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

-- vim.o.winbar = "%f %m"
-- vim.opt.winbar = '%{%v:lua.require("ui.winbar")()%}'
