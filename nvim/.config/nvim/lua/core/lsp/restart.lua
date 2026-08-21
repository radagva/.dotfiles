local M = {}

local function restart_client(client)
	local config = client.config
	local buffers = vim.tbl_keys(client.attached_buffers or {})

	client:stop()

	local timer = assert(vim.uv.new_timer())
	timer:start(
		500,
		100,
		vim.schedule_wrap(function()
			if not client:is_stopped() then
				return
			end
			timer:stop()
			timer:close()

			local id = vim.lsp.start(config, { attach = false })
			if not id then
				return
			end
			for _, buf in ipairs(buffers) do
				vim.lsp.buf_attach_client(buf, id)
			end
		end)
	)
end

function M.restart_buffer_clients()
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then
		vim.notify("No LSP clients attached to buffer", vim.log.levels.WARN, { title = "LSP" })
		return
	end

	local names = vim.tbl_map(function(client)
		return client.name
	end, clients)

	for _, client in ipairs(clients) do
		restart_client(client)
	end

	vim.notify("Restarting: " .. table.concat(names, ", "), vim.log.levels.INFO, { title = "LSP" })
end

return M
