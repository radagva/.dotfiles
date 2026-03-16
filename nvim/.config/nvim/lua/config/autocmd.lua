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
		vim.keymap.set("n", "o", ":LoadLastSession<CR>", { buffer = true, desc = "Load last session", silent = true })
	end,
})

-- local cmdGrp = vim.api.nvim_create_augroup("cmdline_height", { clear = true })
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
-- 		-- Defer setting cmdheight=0 to allow messages to display
-- 		vim.defer_fn(function()
-- 			set_cmdheight(0)
-- 		end, 100)
-- 	end,
-- })

vim.api.nvim_create_user_command("TermHl", function()
	local b = vim.api.nvim_create_buf(false, true)
	local chan = vim.api.nvim_open_term(b, {})
	vim.api.nvim_chan_send(chan, table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n"))
	vim.api.nvim_win_set_buf(0, b)
end, { desc = "Highlights ANSI termcodes in curbuf" })

local winbar_filetype_exclude = {
	"help",
	"snacks_layout_box",
	-- "startify",
	-- "dashboard",
	-- "packer",
	-- "neogitstatus",
	-- "NvimTree",
	-- "Trouble",
	-- "alpha",
	-- "lir",
	-- "Outline",
	-- "spectre_panel",
	-- "toggleterm",
	-- pt
}

local excludes = function()
	if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
		vim.opt_local.winbar = nil
		return true
	end

	return false
end

-- vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "BufWritePost" }, {
-- 	callback = function()
-- 		require("ui.winbar")()
-- 	end,
-- })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	pattern = winbar_filetype_exclude,
-- 	callback = function()
-- 		-- if excludes() then
-- 		vim.opt_local.winbar = nil
-- 		-- end
-- 	end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.go" },
	callback = function(args)
		vim.lsp.buf.format()
		vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
		vim.lsp.buf.code_action({ context = { only = { "source.fixAll" } }, apply = true })
	end,
})
