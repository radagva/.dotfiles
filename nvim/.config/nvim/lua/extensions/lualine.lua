local M = {}

M.debugger = {
	function()
		local status = require("dap").status()
		return status ~= "" and status or nil
	end,
	cond = function()
		return require("dap").session() ~= nil
	end,
	color = { fg = "#ff9e64" },
	on_click = function()
		require("dap").continue()
	end,
}

M.ip_address = function()
	local handle = io.popen("ipconfig getifaddr en0")
	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return output:gsub("%s+$", "")
	end

	return "localhost"
end

M.pretty_path = function(path)
	local rel_path = vim.fn.fnamemodify(path, ":~:.")

	local parts = vim.split(rel_path, "/", { plain = true })

	if #parts > 3 then
		parts = { "…", parts[#parts - 1], parts[#parts] }
	end

	return table.concat(parts, "/")
end

M.bg = "none"
-- M.bg = "#181825"

return M
