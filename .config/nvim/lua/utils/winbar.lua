local M = {}

local get_project_root = function()
	local markers = { ".git", "package.json", "Makefile", "README.md" }
	for _, marker in ipairs(markers) do
		local root = vim.fs.find(marker, { upward = true })[1]
		if root then
			root = vim.fs.dirname(root)
			return vim.fn.fnamemodify(root, ":p"):gsub("\\", "/"):gsub("/$", "")
		end
	end
	return vim.fn.fnamemodify(vim.loop.cwd(), ":p"):gsub("\\", "/"):gsub("/$", "")
end

M.get_winbar = function()
	local filepath = vim.api.nvim_buf_get_name(0)
	if filepath == "" then
		return ""
	end

	-- Normalize paths
	filepath = vim.fn.fnamemodify(filepath, ":p"):gsub("\\", "/"):gsub("/$", "")
	local root = get_project_root()

	if not filepath:find(root, 1, true) == 1 then
		root = vim.fn.fnamemodify(vim.loop.cwd(), ":p"):gsub("\\", "/"):gsub("/$", "")
	end

	local relative_path = filepath:sub(#root + 2)
	if relative_path == "" then
		return vim.fs.basename(root)
	end

	local sep = "%#WinbarSeparator#  %*" -- Styled separator
	local parts = {}

	-- Split path into components
	for part in relative_path:gmatch("[^/]+") do
		table.insert(parts, part)
	end

	-- Add project name
	table.insert(parts, 1, vim.fs.basename(root))

	-- Get diagnostics status
	local has_error = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0
	local has_warning = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }) > 0

	-- Apply colors based on diagnostics
	local filename_color = "%#WinbarFilename#"
	if has_error then
		filename_color = "%#DiagnosticError#" -- Red for errors
	elseif has_warning then
		filename_color = "%#DiagnosticWarn#" -- Yellow for warnings
	end

	if #parts > 0 then
		local ok, devicons = pcall(require, "nvim-web-devicons")
		if ok then
			local icon, _ = devicons.get_icon(parts[#parts])
			if icon then
				parts[#parts] = string.format(
					"%%#DevIcon%s#%s%%* %s%s%%*",
					parts[#parts]:match("(%w+)"), -- Extract base filename for highlight group
					icon,
					filename_color,
					parts[#parts]
				)
			else
				parts[#parts] = filename_color .. parts[#parts] .. "%*"
			end
		end
	end

	return table.concat(parts, sep)
end

return M
