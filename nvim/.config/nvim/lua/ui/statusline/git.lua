local theme = require("ui.statusline.theme")

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
		theme.accent("git", "branch", "\u{e725} "), -- branch icon
		head .. " ",
		theme.accent("git", "added", added),
		theme.accent("git", "changed", changed),
		theme.accent("git", "removed", removed),
	})
end
