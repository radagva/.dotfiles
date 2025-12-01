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

	return colors.hl(colors.highlights.comment, table.concat(parts, "/"):gsub("/", "  ") .. "  ") .. split[#split]
end
