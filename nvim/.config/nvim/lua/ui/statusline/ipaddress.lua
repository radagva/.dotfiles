local colors = require("utils.colors")
local hl = colors.hl
local highlights = colors.highlights

return function()
	local handle = io.popen("ipconfig getifaddr en0")

	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return hl(highlights.wifi, colors.exthl({ bg = "#353535", fg = "#A5D6FF" }, "  ")) .. output:gsub("%s+$", "")
	end

	return "nonip"
end
