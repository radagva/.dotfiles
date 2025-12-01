return function()
	local params = {
		textDocument = vim.lsp.util.make_text_document_params(),
		position = vim.api.nvim_win_get_cursor(0),
	}

	local clients = vim.lsp.get_active_clients({ bufnr = 0 })
	for _, client in ipairs(clients) do
		if client.supports_method("textDocument/documentSymbol") then
			local request_success, result = pcall(function()
				return client.request_sync("textDocument/documentSymbol", params, 100, 0)
			end)

			if request_success and result and result.result then
				local symbols = result.result
				local current_line = params.position[1] -- 1-indexed line
				local scope = {}

				-- Recursive function to find the symbol hierarchy at the current position
				local function find_symbol_hierarchy(symbol_list, depth)
					for _, symbol in ipairs(symbol_list) do
						local start_line = symbol.range.start.line + 1 -- Convert to 1-indexed
						local end_line = symbol.range["end"].line + 1 -- Convert to 1-indexed

						if current_line >= start_line and current_line <= end_line then
							table.insert(scope, symbol.name)

							-- Recursively search in children if available
							if symbol.children then
								find_symbol_hierarchy(symbol.children, depth + 1)
							end
							break
						end
					end
				end

				find_symbol_hierarchy(symbols, 1)
				return scope
			end
		end
	end

	return nil
end
