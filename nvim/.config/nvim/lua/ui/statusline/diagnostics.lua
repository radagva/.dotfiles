local theme = require("ui.statusline.theme")

return function()
	local diagnostics = {}

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	if errors > 0 then
		table.insert(diagnostics, theme.accent("diag", "error", "\u{ea87} " .. errors))
	end

	if warnings > 0 then
		table.insert(diagnostics, theme.accent("diag", "warn", "\u{f071} " .. warnings))
	end

	return table.concat(diagnostics, " ")
end
