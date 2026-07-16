local theme = require("ui.statusline.theme")

return function()
	local handle = io.popen("ipconfig getifaddr en0")

	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return theme.accent("lc", "wifi", "\u{f1eb}  ") .. output:gsub("%s+$", "")
	end

	return "nonip"
end
