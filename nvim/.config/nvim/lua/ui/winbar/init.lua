local filepath = require("ui.winbar.filepath")

return function()
	local value = " " .. table.concat({
		filepath(),
		"%m",
	}, " ") .. " "

	return value

	-- local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
	--
	-- if not status_ok then
	-- 	return
	-- end
end
