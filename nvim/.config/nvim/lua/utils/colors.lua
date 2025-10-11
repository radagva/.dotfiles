local utils = {
	highlights = {
		wifi = "@constant.builtin",
		git_branch = "@lsp.type.method",
		debugger = "@lsp.type.parameter",
	},
}

utils.hl = function(group, text)
	return string.format("%%#%s#%s%%*", group, text)
end

return utils
