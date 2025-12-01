local filepath = require("ui.winbar.filepath")

return function()
	return " " .. table.concat({
		filepath(),
		"%m",
	}, " ") .. " "
end
