return {
	"mistweaverco/kulala.nvim",
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
		lsp = {
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<C-r>", function()
					require("kulala").run()
				end, { silent = true, buffer = bufnr, noremap = true })
			end,
		},
	},
}
