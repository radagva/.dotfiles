local gh = require("config.utils").gh

vim.pack.add({
	gh("tpope/vim-dadbod"),
	gh("kristijanhusak/vim-dadbod-completion"),
	gh("kristijanhusak/vim-dadbod-ui"),
})

vim.g.db_ui_use_nerd_fonts = 1

vim.keymap.set("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Toggle DB UI" })
