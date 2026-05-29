local filepath = require("ui.winbar.filepath")

return function()
	local value = " " .. table.concat({
		filepath(),
		"%m",
	}, " ") .. " "

	return value
end
