function ListAttachedLspClients()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("No LSP clients attached to current buffer")
		return
	end

	print("LSP clients attached to current buffer:")
	for _, client in ipairs(clients) do
		print(string.format("  • %s (id: %d)", client.name, client.id))
	end
end

vim.api.nvim_create_user_command("LspList", ListAttachedLspClients, {
	desc = "List all LSP clients attached to the current buffer",
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function(_)
		vim.lsp.buf.format()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
	end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.html",
	callback = function(args)
		local buf_path = vim.api.nvim_buf_get_name(args.buf)
		if buf_path == "" then
			return
		end
		local found = vim.fs.find("angular.json", { upward = true, path = buf_path })
		if #found > 0 then
			vim.bo[args.buf].filetype = "htmlangular"
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Start treesitter for highlighting and indentation",
	callback = function()
		pcall(vim.treesitter.start)
		-- vim.bo.indentexpr = "v:lua.vim.treesitter.indentexpr()"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typescript", "typescriptreact" },
	callback = function(ev)
		vim.keymap.set("n", "K", require("ts_expand_hover").hover, {
			buffer = ev.buf,
			desc = "TypeScript expandable hover",
		})
	end,
})
