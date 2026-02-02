local colors = require("utils.colors")

return function()
	local status = require("dap").status()
	return status ~= "" and colors.hl(colors.highlights.debugger, " ") .. status or ""
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
