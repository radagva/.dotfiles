---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python

local function set_python_path(path)
	local clients = vim.lsp.get_clients({
		bufnr = vim.api.nvim_get_current_buf(),
		name = "basedpyright",
	})
	for _, client in ipairs(clients) do
		if client.settings then
			client.settings.python = vim.tbl_deep_extend("force", client.settings.python or {}, { pythonPath = path })
		else
			client.config.settings =
				vim.tbl_deep_extend("force", client.config.settings, { python = { pythonPath = path } })
		end
		client.notify("workspace/didChangeConfiguration", { settings = nil })
	end
end

---@type vim.lsp.Config
return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"uv.lock",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		pyright = {
			codeActions = {
				source = {
					addMissingImports = true, -- Ensure this is enabled
				},
			},
		},
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
	on_attach = function(client, bufnr)
		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightOrganizeImports", function()
			client:exec_cmd({
				command = "basedpyright.organizeimports",
				arguments = { vim.uri_from_bufnr(bufnr) },
			})
		end, {
			desc = "Organize Imports",
		})

		vim.api.nvim_buf_create_user_command(bufnr, "LspPyrightSetPythonPath", set_python_path, {
			desc = "Reconfigure basedpyright with the provided python path",
			nargs = 1,
			complete = "file",
		})

		local add_missing_imports = function()
			vim.lsp.buf.code_action({
				apply = true,
				context = {
					diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
				},
			})
			-- vim.lsp.buf.code_action({
			-- 	apply = true,
			-- 	context = {
			-- 		-- Remove `only` to see ALL available actions (debugging)
			-- 		diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
			-- 	},
			-- })
			-- local ok, result = pcall(vim.lsp.buf.code_action, {
			--   apply = true,
			--   context = {
			--     only = { "source.addMissingImports" },
			--     diagnostics = {},
			--   },
			-- })
			-- if not ok then
			--   vim.notify("No missing imports found or action failed.", vim.log.levels.WARN)
			-- end
		end
		vim.keymap.set("n", "<leader>cm", add_missing_imports, { desc = "Add [M]issing imports" })
	end,
}
