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
