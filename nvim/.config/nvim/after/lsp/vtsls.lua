local vue_language_server_path = vim.fn.expand("$MASON/packages")
	.. "/vue-language-server"
	.. "/node_modules/@vue/language-server"

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

return {
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
	settings = {
		typescript = {
			inlayHints = {
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				variableTypes = { enabled = false },
				propertyDeclarationTypes = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				enumMemberValues = { enabled = true },
			},
		},
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
	default_config = {
		settings = {},
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
