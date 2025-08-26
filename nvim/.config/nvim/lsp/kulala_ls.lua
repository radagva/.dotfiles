---@type vim.lsp.Config
return {
	cmd = { "kulala-ls" },
	filetypes = { "http", "http" },

	on_attach = function()
		vim.keymap.set("n", "<C-r>", function()
			require("kulala").run()
		end, { silent = true })
	end,
}
