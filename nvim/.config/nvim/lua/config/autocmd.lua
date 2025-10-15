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

-- You can also create a more detailed version with additional information:
function ListAttachedLspClientsDetailed()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		print("No LSP clients attached to current buffer")
		return
	end

	print("LSP clients attached to current buffer:")
	for _, client in ipairs(clients) do
		print(string.format("  • Name: %s", client.name))
		print(string.format("    ID: %d", client.id))
		print(string.format("    Root directory: %s", client.root_dir or "N/A"))
		print(string.format("    File types: %s", table.concat(client.filetypes or {}, ", ")))
		print("")
	end
end

-- Set up a command for easy access
vim.api.nvim_create_user_command("LspList", ListAttachedLspClients, {
	desc = "List all LSP clients attached to the current buffer",
})

-- Alternative: Return the clients as a table for programmatic use
function GetAttachedLspClients()
	local bufnr = vim.api.nvim_get_current_buf()
	return vim.lsp.get_clients({ bufnr = bufnr })
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "startify",
	callback = function()
		vim.keymap.set("n", "o", ":LoadLastSession<CR>", { buffer = true, desc = "Open file explorer" })
	end,
})
