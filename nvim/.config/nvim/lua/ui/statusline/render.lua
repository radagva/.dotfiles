-- Powerline assembly: turns lists of { style, content } into statusline
-- strings. Knows about shape and separators, never about color -- every color
-- arrives as an opaque style token from `theme`.

local theme = require("ui.statusline.theme")

local M = {}

local ARROW_R = "\u{e0b0}" -- , trails a left-side segment
local ARROW_L = "\u{e0b2}" -- , leads a right-side segment

local function content_of(seg)
	-- Components reset with `%*` after their own coloring; rewrite that back to
	-- the segment's group so the rest of the text stays inside the block.
	local text = (" " .. seg.content .. " "):gsub("%%[*]", "%%#" .. seg.style.hl .. "#")
	return ("%%#%s#%s"):format(seg.style.hl, text)
end

-- Each segment is followed by a wedge into the next segment's seam. `trailing`
-- adds a wedge after the last segment, tapering into the transparent middle.
function M.left(segs, trailing)
	if #segs == 0 then
		return ""
	end

	local parts = {}

	for i, seg in ipairs(segs) do
		table.insert(parts, content_of(seg))

		if i < #segs or trailing then
			local next_seam = (segs[i + 1] and segs[i + 1].style.seam) or "none"
			table.insert(parts, theme.wedge(seg.style.seam, next_seam, ARROW_R))
		end
	end

	return table.concat(parts)
end

-- Each segment is preceded by a wedge sitting on the previous segment's seam.
-- `leading` adds a wedge before the first segment, emerging from the middle.
function M.right(segs, leading)
	if #segs == 0 then
		return ""
	end

	local parts = {}

	for i, seg in ipairs(segs) do
		if i > 1 or leading then
			local prev_seam = (segs[i - 1] and segs[i - 1].style.seam) or "none"
			table.insert(parts, theme.wedge(seg.style.seam, prev_seam, ARROW_L))
		end

		table.insert(parts, content_of(seg))
	end

	return table.concat(parts)
end

-- The stretching gap between the two chains.
function M.gap()
	return ("%%#%s#%%="):format(theme.fill())
end

return M
