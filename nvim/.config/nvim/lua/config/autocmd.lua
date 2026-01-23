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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.html",
	callback = function()
		if vim.fn.findfile("angular.json", vim.fn.getcwd() .. ";") ~= "" then
			vim.bo.filetype = "htmlangular"
		end
	end,
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

-- local cmdGrp = vim.api.nvim_create_augroup("cmdline_height", { clear = true })
--
-- local function set_cmdheight(val)
-- 	if vim.opt.cmdheight:get() ~= val then
-- 		vim.opt.cmdheight = val
-- 		vim.cmd.redrawstatus()
-- 	end
-- end
--
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
-- 	group = cmdGrp,
-- 	callback = function()
-- 		if vim.fn.getcmdtype() == ":" then
-- 			set_cmdheight(1)
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineChanged", {
-- 	group = cmdGrp,
-- 	callback = function()
-- 		if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "" then
-- 			set_cmdheight(0)
-- 		end
-- 	end,
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
-- 	group = cmdGrp,
-- 	callback = function()
-- 		set_cmdheight(0)
-- 	end,
-- })

local cmdGrp = vim.api.nvim_create_augroup("cmdline_height", { clear = true })
local function set_cmdheight(val)
	if vim.opt.cmdheight:get() ~= val then
		vim.opt.cmdheight = val
		vim.cmd.redrawstatus()
	end
end

vim.api.nvim_create_autocmd("CmdlineEnter", {
	group = cmdGrp,
	callback = function()
		if vim.fn.getcmdtype() == ":" then
			set_cmdheight(1)
		end
	end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
	group = cmdGrp,
	callback = function()
		if vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == "" then
			set_cmdheight(0)
		end
	end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
	group = cmdGrp,
	callback = function()
		-- Defer setting cmdheight=0 to allow messages to display
		vim.defer_fn(function()
			set_cmdheight(0)
		end, 100)
	end,
})
