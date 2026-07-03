local filepath = require("ui.winbar.filepath")

local function should_show_winbar()
	if vim.bo.buftype ~= "" then
		return false
	end
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname == "" then
		return false
	end
	return true
end

local M = {}

function M.setup()
	local augroup = vim.api.nvim_create_augroup("Winbar", { clear = true })

	local function update_winbar()
		if should_show_winbar() then
			vim.wo.winbar = '%{%v:lua.require("ui.winbar").get()%}'
		else
			vim.wo.winbar = nil
		end
	end

	vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
		group = augroup,
		callback = update_winbar,
	})

	-- Apply to the initial window as well
	vim.schedule(update_winbar)
end

function M.get()
	local value = " " .. table.concat({
		filepath(),
		"%m",
	}, " ") .. " "

	return value
end

setmetatable(M, { __call = function(_, ...)
	return M.get(...)
end })

return M
