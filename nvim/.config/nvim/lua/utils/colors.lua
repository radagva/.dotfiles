-- local merge = require("utils").merge

local utils = {
	highlights = {
		comment = "Comment",
		wifi = "@constant.builtin",
		git_branch = "@lsp.type.method",
		debugger = "@lsp.type.parameter",
	},
}

utils.hl = function(group, text)
	return string.format("%%#%s#%s%%*", group, text)
end

utils.exthl = function(colors, text)
	local hl_name = "ExtHL"
	if colors.link then
		hl_name = hl_name .. "_link_" .. colors.link
	end
	if colors.bg then
		hl_name = hl_name .. "_bg_" .. colors.bg:gsub("#", "")
	end
	if colors.fg then
		hl_name = hl_name .. "_fg_" .. colors.fg:gsub("#", "")
	end

	vim.api.nvim_set_hl(0, hl_name, colors)
	return string.format("%%#%s#%s%%*", hl_name, text)
end

return utils
