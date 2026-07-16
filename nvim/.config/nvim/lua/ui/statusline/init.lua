local c = require("utils.colors")
local mode_mod = require("ui.statusline.mode")
local git_mod = require("ui.statusline.git")
local diag_mod = require("ui.statusline.diagnostics")
local dap_mod = require("ui.statusline.dap")
local ip_mod = require("ui.statusline.ipaddress")

Statusline = {}

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
	return name
end

local MODE_COLORS = {
	n = { bg = "#82D9C2", fg = "#101010" },
	i = { bg = "#A0A0A0", fg = "#101010" },
	v = { bg = "#FFCFA8", fg = "#101010" },
	[""] = { bg = "#E8B88A", fg = "#101010" },
	s = { bg = "#FFCFA8", fg = "#101010" },
	S = { bg = "#FFCFA8", fg = "#101010" },
	[""] = { bg = "#E8B88A", fg = "#101010" },
	R = { bg = "#FF8080", fg = "#101010" },
	c = { bg = "#FFC799", fg = "#101010" },
	t = { bg = "#82D9C2", fg = "#101010" },
}

local FADE = {
	git = { bg = "#353535", fg = "#CCCCCC" },
	diag = { bg = "#1e1e1e", fg = "#999999" },
	dap = { bg = "#1e1e1e", fg = "#999999" },
	lc = { bg = "#353535", fg = "#CCCCCC" },
}

local H_STATIC = {
	git = hl("StlGit", FADE.git),
	diag = hl("StlDiag", FADE.diag),
	dap = hl("StlDap", FADE.dap),
	lc = hl("StlLc", FADE.lc),
}

-- Transparent group used to reset the active highlight so the `%=` padding
-- region does not inherit (and stretch) the last segment's background.
local H_FILL = hl("StlFill", { bg = "none" })

-- Powerline separators. The right-pointing wedge trails a left-aligned segment;
-- the left-pointing wedge leads a right-aligned one. In both cases the triangle's
-- fg is the current segment's bg and its bg is the *neighbouring* item's bg, so
-- adjacent blocks meet seamlessly. The edge that faces the transparent middle
-- uses bg = "none". exthl keys the group by color, so connectors never clobber.
local ARROW_R = "\u{e0b0}" -- , trails a left-side segment
local ARROW_L = "\u{e0b2}" -- , leads a right-side segment

local function seg_content(seg)
	local content = " " .. seg.content .. " "
	content = content:gsub("%%[*]", "%%#" .. seg.hl .. "#")
	return ("%%#%s#%s"):format(seg.hl, content)
end

-- Left chain: each segment is followed by a wedge into the next segment's bg.
-- `trailing` adds a wedge after the last segment tapering into the middle.
local function build_left(segs, trailing)
	if #segs == 0 then
		return ""
	end

	local parts = {}

	for i, seg in ipairs(segs) do
		table.insert(parts, seg_content(seg))

		if i < #segs or trailing then
			local next_bg = (segs[i + 1] and segs[i + 1].bg) or "none"
			table.insert(parts, c.exthl({ fg = seg.bg, bg = next_bg }, ARROW_R))
		end
	end

	return table.concat(parts)
end

-- Right chain: each segment is preceded by a wedge sitting on the previous
-- segment's bg. `leading` adds a wedge before the first segment emerging from
-- the transparent middle.
local function build_right(segs, leading)
	if #segs == 0 then
		return ""
	end

	local parts = {}

	for i, seg in ipairs(segs) do
		if i > 1 or leading then
			local prev_bg = (segs[i - 1] and segs[i - 1].bg) or "none"
			table.insert(parts, c.exthl({ fg = seg.bg, bg = prev_bg }, ARROW_L))
		end

		table.insert(parts, seg_content(seg))
	end

	return table.concat(parts)
end

function Statusline.activate()
	local mode = vim.api.nvim_get_mode().mode
	local mc = MODE_COLORS[mode] or MODE_COLORS.n
	local mode_hl = hl("StlMode", mc)

	local left = {}

	table.insert(left, { hl = mode_hl, bg = mc.bg, content = mode_mod() })

	local git = git_mod()
	if git ~= "" then
		table.insert(left, { hl = H_STATIC.git, bg = FADE.git.bg, content = git })
	end

	local diag = diag_mod()
	if diag ~= "" then
		table.insert(left, { hl = H_STATIC.diag, bg = "none", content = diag })
	end

	local right = {}

	local dap = dap_mod()
	if dap ~= "" then
		table.insert(right, { hl = H_STATIC.dap, bg = FADE.dap.bg, content = dap })
	end

	table.insert(right, { hl = H_STATIC.lc, bg = FADE.lc.bg, content = "%l:%c" })

	local ip = ip_mod()
	table.insert(right, { hl = H_STATIC.lc, bg = FADE.lc.bg, content = ip })

	-- Reset to a transparent highlight before `%=` so the middle padding
	-- stays fully transparent instead of inheriting the last segment's bg.
	return build_left(left, true) .. ("%%#%s#%%="):format(H_FILL) .. build_right(right, true)
end

function Statusline.deactivate()
	return ""
end

local group = vim.api.nvim_create_augroup("Statusline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate statusline on focus",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.activate()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate statusline when unfocused",
	callback = function()
		vim.opt_local.statusline = "%!v:lua.Statusline.deactivate()"
	end,
})
