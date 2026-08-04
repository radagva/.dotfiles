local filepath = require("ui.winbar.filepath")

local WINBAR = '%{%v:lua.require("ui.winbar").get()%}'

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

-- Plugins like dap-view, neo-tree and oil render their own winbar, so leave
-- those windows alone instead of clearing what they just set
local function has_foreign_winbar()
	local current = vim.wo.winbar
	return current ~= "" and current ~= WINBAR
end

local M = {}

function M.setup()
	local augroup = vim.api.nvim_create_augroup("Winbar", { clear = true })

	local function update_winbar()
		if should_show_winbar() then
			vim.wo.winbar = WINBAR
		elseif not has_foreign_winbar() then
			vim.wo.winbar = ""
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
