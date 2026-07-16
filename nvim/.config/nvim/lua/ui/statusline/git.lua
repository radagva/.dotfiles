local c = require("utils.colors")

-- Shared background for the whole git segment. Every piece that switches
-- foreground color (branch icon, diff counts) must keep this background so the
-- segment reads as one solid block behind the separator triangle.
local BG = "#353535"

-- Resolve a highlight group's foreground to a hex string so it can be reused
-- on top of BG instead of dragging in that group's own (inconsistent) bg.
local function fg_hex(group)
	local ok, h = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok and h and h.fg then
		return string.format("#%06x", h.fg)
	end
	return nil
end

-- Render `text` with `group`'s foreground but the segment's shared background.
local function themed(group, text)
	if text == "" then
		return ""
	end
	return c.exthl({ fg = fg_hex(group), bg = BG }, text)
end

return function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end

	local head = git_info.head
	local added = (git_info.added and git_info.added > 0) and (" +" .. git_info.added) or ""
	local changed = (git_info.changed and git_info.changed > 0) and (" ~" .. git_info.changed) or ""
	local removed = (git_info.removed and git_info.removed > 0) and (" -" .. git_info.removed) or ""

	return table.concat({
		themed(c.highlights.git_branch, "\u{e725} "), -- branch icon
		head .. " ",
		themed("GitSignsAdd", added),
		themed("GitSignsChange", changed),
		themed("GitSignsDelete", removed),
	})
end
