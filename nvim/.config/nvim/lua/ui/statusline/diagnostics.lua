local colors = require("utils.colors")

return function()
	local diagnostics = {}

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	if errors > 0 then
		table.insert(diagnostics, colors.hl("ErrorMsg", " " .. errors))
	end

	if warnings > 0 then
		table.insert(diagnostics, colors.hl("WarningMsg", " " .. warnings))
	end

	return table.concat(diagnostics, " ")
end
