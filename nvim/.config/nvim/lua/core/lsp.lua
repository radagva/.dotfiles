vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"gopls",
	"sqlls",
	"eslint",
	"clangd",
	"basedpyright",
	"tailwindcss",
	"emmet_ls",
	"cssls",
	"astro",
	"terraform",
})

vim.keymap.set("n", "<leader>uh", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
end, { desc = "Toggle inlay hints" })

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "code inline actions" })

vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename symbol", expr = true })

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded", max_width = 600, max_height = 400 })
end, { desc = "Hover Documentation" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf

		-- Only set up keymaps if we have a valid client
		if not client then
			return
		end

		-- Helper function to safely bind LSP functions
		local function safe_lsp_buf_bind(lsp_func, _)
			if type(lsp_func) == "function" then
				return lsp_func
			end

			return function()
				vim.notify("LSP function not available", vim.log.levels.WARN)
			end
		end

		vim.keymap.set(
			"n",
			"gd",
			safe_lsp_buf_bind(vim.lsp.buf.definition),
			{ buffer = bufnr, desc = "LSP: Go to definition" }
		)
		vim.keymap.set(
			"n",
			"gD",
			safe_lsp_buf_bind(vim.lsp.buf.type_definition),
			{ buffer = bufnr, desc = "LSP: Go to type definition" }
		)
		vim.keymap.set(
			"n",
			"gr",
			safe_lsp_buf_bind(vim.lsp.buf.references),
			{ buffer = bufnr, desc = "LSP: Go to references" }
		)
		vim.keymap.set(
			"n",
			"gi",
			safe_lsp_buf_bind(vim.lsp.buf.implementation),
			{ buffer = bufnr, desc = "LSP: Go to implementations" }
		)

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

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})

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
