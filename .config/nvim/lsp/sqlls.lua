local mason_path = vim.fn.stdpath("data") .. "/mason/packages"

return {
	cmd = { mason_path .. "/sqlls/node_modules/.bin/sql-language-server", "up", "--method", "stdio" },
	root_markers = { ".git", ".sqllsrc.json" },
	filetypes = { "sql", "psql", "mysql" },
	settings = {
		sql = {
			execution = {
				paramTypes = true, -- Enable parameter type hints
			},

			engine = "postgresql", -- or 'mysql', 'sqlite', etc.
		},
	},
	on_attach = function(client, bufnr)
		-- Enable completion
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "gd", vim.lsp.buf.definition, "Go to definition")
		map("n", "K", vim.lsp.buf.hover, "Show documentation")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code actions")

		if client.supports_method("textDocument/formatting") then
			map("n", "<leader>f", function()
				vim.lsp.buf.format({ async = true })
			end, "Format buffer")
		end
	end,
}
