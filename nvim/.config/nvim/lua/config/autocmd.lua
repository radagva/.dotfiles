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

function StartTreesitter()
	pcall(vim.treesitter.start)
end

function HighlightYankedcontent()
	vim.hl.on_yank({
		higroup = "IncSearch",
		timeout = 200,
	})
end

vim.api.nvim_create_user_command("LspList", ListAttachedLspClients, {
	desc = "List all LSP clients attached to the current buffer",
})

vim.api.nvim_create_autocmd("FileType", {
	desc = "Start treesitter for highlighting and indentation",
	callback = StartTreesitter,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = HighlightYankedcontent,
})
