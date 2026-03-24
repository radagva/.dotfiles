local colors = require("utils.colors")

return function()
	local bg = "#88C0D0"
	local fg = "#2E3440"

	local status = require("dap").status()
	local a = colors.exthl({ fg = bg, bg = "none" }, "")
	local b = colors.exthl({ bg = bg, fg = fg }, " ")
	local c = colors.exthl({ bg = bg, fg = fg }, " " .. (status or ""))
	local d = colors.exthl({ fg = bg, bg = "none" }, "")

	if status ~= "" then
		return table.concat({ a, b, c, d })
	end

	return ""
	-- return status ~= "" and
	-- return status ~= "" and colors.exthl({ bg = "#E6A75A", fg = "#151515" }, " ") .. status or ""
end
-- M.debugger = {
-- 	function()
-- 		local status = require("dap").status()
-- 		return status ~= "" and status or nil
-- 	end,
-- 	cond = function()
-- 		return require("dap").session() ~= nil
-- 	end,
-- 	color = { fg = "#f5a97f" },
-- 	on_click = function()
-- 		require("dap").continue()
-- 	end,
-- }
