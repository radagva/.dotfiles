require("mini.icons").setup()

-- fidget.setup({
-- 	notification = {
-- 		window = { winblend = 0 },
-- 	},
-- })

require("which-key").setup({ preset = "modern" })

require("showkeys").setup({
	timeout = 1,
	maxkeys = 5,
	-- more opts
})

vim.cmd.colorscheme("dark-2026")
