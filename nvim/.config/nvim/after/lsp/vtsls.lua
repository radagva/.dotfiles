local util = require("lspconfig.util")

return {
	default_config = {
		root_dir = util.root_pattern("tsconfig.json", "angular.json", "package.json", ".git"),
		filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
	},
	on_attach = function(client, bufnr) ---@diagnostic disable-line
		local map = vim.keymap.set

		local organize_imports = function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.organizeImports" },
					diagnostics = {},
				},
			})
		end

		local remove_unused_imports = function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.removeUnused" }, ---@diagnostic disable-line
					diagnostics = {},
				},
			})
		end

		local add_missing_imports = function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					only = { "source.addMissingImports" }, ---@diagnostic disable-line
					diagnostics = {},
				},
			})
		end

		map("n", "<leader>co", organize_imports, { desc = "[O]rganize imports" })
		map("n", "<leader>cu", remove_unused_imports, { desc = "Remove [U]nused imports" })
		map("n", "<leader>cm", add_missing_imports, { desc = "Add [M]issing imports" })
	end,
}
