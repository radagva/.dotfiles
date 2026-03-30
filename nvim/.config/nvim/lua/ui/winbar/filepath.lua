local colors = require("utils.colors")

local function split_string(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t = {}
	for part in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, part)
	end
	return t
end

return function()
	local root_directory = vim.fn.getcwd()
	local relative_path_to_current_file = vim.fn.expand("%:p")

	local project_folder = root_directory:match("([^/]+)$")

	local desired_path = project_folder .. relative_path_to_current_file:sub(#root_directory + 1)

	local split = split_string(desired_path, "/")
	local parts = {}

	for i, segment in ipairs(split) do
		if i ~= #split then
			table.insert(parts, segment)
		end
	end

	local filename = split[#split]
	local path_prefix = colors.hl(colors.highlights.comment, table.concat(parts, "/") .. "/")

	local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

	local filename_colored = filename
	if errors > 0 then
		filename_colored = colors.hl("ErrorMsg", filename)
	elseif warnings > 0 then
		filename_colored = colors.hl("WarningMsg", filename)
	end

	local modified_indicator = ""
	if vim.bo.modified then
		modified_indicator = colors.hl("WarningMsg", " ●")
	end

	return path_prefix .. filename_colored .. modified_indicator
end
