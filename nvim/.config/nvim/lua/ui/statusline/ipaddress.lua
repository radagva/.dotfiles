local colors = require("utils.colors")
local hl = colors.hl
local highlights = colors.highlights

return function()
	local handle = io.popen("ipconfig getifaddr en0")

	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return hl(highlights.wifi, " ") .. output:gsub("%s+$", "")
	end

	return "nonip"
end
