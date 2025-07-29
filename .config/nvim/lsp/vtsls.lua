return {
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
	cmd = { "vtsls", "--stdio" },
	root_markers = {
		".git",
		"tsconfig.json",
	},
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		javascript = {
			suggest = {
				names = false,
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
				names = false,
			},
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = false },
			},
		},
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
