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

-- utils.override = function(hl, overrides)
-- 	hl.Pmenu = { bg = "none", fg = "none" }
-- 	hl.PmenuThumb = { bg = "#5b6078" }
-- 	hl.BlinkCmpMenuBorder = { fg = "", bg = "none" }
-- 	hl.NormalFloat = { bg = "none" }
-- 	hl.Float = { bg = "none" }
-- 	hl.FloatBorder = { bg = "none" }
-- 	hl.FloatTitle = { bg = "none" }
-- 	hl.WinBar = { bg = "none" }
-- 	hl.WinBarNC = { bg = "none" }
-- 	hl.TabLineFill = { bg = "none", fg = "none" }
-- 	hl.StatusLine = { bg = "none" }
-- 	hl.StatusLineNC = { bg = "none" }
-- 	hl.GitSignsCurrentLineBlame = { fg = "#5b6078" }
--
-- 	return merge(hl, overrides or {})
-- end

return utils
