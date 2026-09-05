local theme = require("ui.statusline.theme")

local cached = {}

local function run(cmd)
	local out = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 then
		return ""
	end
	return table.concat(out, "\n")
end

local function refresh()
	local branch = run({ "git", "rev-parse", "--abbrev-ref", "HEAD" })
	if branch == "" then
		cached = {}
		return
	end

	local stat = run({ "git", "diff", "--numstat" })
	local added, changed, removed = 0, 0, 0
	for line in stat:gmatch("[^\n]+") do
		local a, c, r = line:match("^(%d+)%s+(%d+)%s+(%d+)")
		if a then
			added = added + tonumber(a)
			changed = changed + tonumber(c)
			removed = removed + tonumber(r)
		end
	end

	cached = { head = branch, added = added, changed = changed, removed = removed }
end

local group = vim.api.nvim_create_augroup("StatuslineGit", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter", "BufWritePost" }, {
	group = group,
	desc = "Refresh cached git info for statusline",
	callback = function()
		refresh()
	end,
})

return function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		git_info = next(cached) and cached or nil
	end
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
