vim.lsp.enable({
	"lua_ls",
	"vtsls",
	"angularls",
	"gopls",
	"sqlls",
	"eslint",
	"basedpyright",
	"clangd",
})

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Add [M]issing imports" })
vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[R]ename symbol" })
vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Hover Documentation" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		local fzf = require("fzf-lua")

		vim.keymap.set("n", "gd", fzf.lsp_definitions, { desc = "Go to definition" })
		vim.keymap.set("n", "gr", fzf.lsp_references, { desc = "Go to references" })

		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_next({ float = true })
		end, { desc = "Next Diagnostic" })

		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_prev({ float = true })
		end, { desc = "Previous Diagnostic" })

		--[[
    -- I'm adding this here because for some reason this is not working
    -- if I add it in treesitter init function or options file
    --]]
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
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
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
