local M = {}

local MAX_LINES = 5000

local function read_lines()
	local path = vim.lsp.log.get_filename()
	if vim.fn.filereadable(path) == 0 then
		return { "No LSP log file found." }
	end

	local lines = vim.fn.readfile(path)
	if #lines == 0 then
		return { "LSP log is empty." }
	end
	if #lines > MAX_LINES then
		lines = vim.list_slice(lines, #lines - MAX_LINES + 1, #lines)
	end
	return lines
end

local function set_lines(win, lines)
	vim.bo[win.buf].modifiable = true
	vim.api.nvim_buf_set_lines(win.buf, 0, -1, false, lines)
	vim.bo[win.buf].modifiable = false
	vim.api.nvim_win_set_cursor(win.win, { #lines, 0 })
end

function M.open()
	Snacks.win({
		title = " LSP Log ",
		style = "float",
		border = "rounded",
		backdrop = false,
		ft = "log",
		wo = { wrap = false, cursorline = true },
		keys = {
			R = { function(win)
				set_lines(win, read_lines())
			end, desc = "refresh" },
		},
		footer_keys = true,
		on_win = function(win)
			set_lines(win, read_lines())
		end,
	})
end

return M
