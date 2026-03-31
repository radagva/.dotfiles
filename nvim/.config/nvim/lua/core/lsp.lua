vim.lsp.enable({
	"lua_ls",
	"gopls",
	"gofumpt",
	"basedpyright",
	"ruff",
	"eslint",
	"tailwindcss",
	"postgres_lsp",
	"clangd",
	"cssls",
	"cssmodules_ls",
	"terraform",
	"vtsls",
	"yamlls",
	"jsonls",
})

vim.keymap.set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>c", "", { desc = "Code" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code inline actions" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename symbol" })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 80 })
end, { desc = "Hover Documentation" })

vim.keymap.set("n", "<leader>cli", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle [i]nlay hints", silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		vim.lsp.inlay_hint.enable()
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Only set up keymaps if we have a valid client
		if not client then
			return
		end

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to definition" })
		vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "LSP: Go to type definition" })
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: Go to references" })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr, desc = "LSP: Go to implementations" })

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, { desc = "Next Diagnostic" })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, { desc = "Previous Diagnostic" })

		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
	end,
})

-- vim.lsp.config("*", {
-- 	capabilities = require("blink.cmp").get_lsp_capabilities(),
-- })

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = " ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})
