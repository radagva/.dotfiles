return function()
	local status = require("dap").status()
	if status == "" then
		return ""
	end
	return "\u{eae8} " .. status
end
