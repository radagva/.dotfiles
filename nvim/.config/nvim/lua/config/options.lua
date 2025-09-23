-- colors
vim.opt.termguicolors = true

-- statuscolumn
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = [[%s%=%@v:relnum@%{v:relnum == 0 ? v:lnum : v:relnum}  ]]
vim.opt.numberwidth = 1
vim.opt.fillchars = { eob = " " }

-- editor text
vim.o.clipboard = "unnamedplus"
-- vim.opt.linespace = 6
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
vim.opt.conceallevel = 2

vim.opt.sessionoptions = "buffers,curdir,folds,winsize,terminal"

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.filetype == "neo-tree" then
-- 			vim.opt_local.winbar = ""
-- 			return
-- 		end
-- 		local current_winbar = vim.api.nvim_get_option_value("winbar", { scope = "local" })
-- 		if current_winbar and current_winbar ~= "" then
-- 			return
-- 		end
--
-- 		if vim.wo.winbar ~= nil and vim.wo.winbar ~= "" then
-- 			return
-- 		end
--
-- 		vim.o.winbar = " %{%v:lua.require('utils.winbar').get_winbar()%}"
-- 	end,
-- })

-- @important this is to keep the "editor"'s buffer "opened" while keeping edge buffers in-place
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3

-- code folding
vim.o.foldenable = true
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "1"

-- vim.o.winborder = "rounded"
