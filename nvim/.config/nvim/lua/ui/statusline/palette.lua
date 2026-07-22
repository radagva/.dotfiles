-- Derives the statusline palette from whatever colorscheme is active, by
-- borrowing colors from the groups that scheme already defines. Nothing here
-- is scheme-specific: load a new colorscheme and the bar follows it.
--
-- The anchors below are the ones the old hardcoded palette turned out to be
-- using already -- it was Vesper's String/Function/DiagnosticError/... read off
-- by hand. This just does that lookup at runtime instead.

local M = {}

-- Contrast anchors. Not scheme colors: these are the two extremes text is
-- placed against when a mode background needs something readable on top.
local INK = "#101010"
local PAPER = "#EEEEEE"

-- Which groups each entry borrows from, tried in order. Every colorscheme in
-- plugin/colorschemes defines all of these, but the fallbacks keep a sparse
-- scheme from leaving the bar colorless.
local anchors = {
	text = { "Normal", "StatusLine" },
	muted = { "Comment", "NonText" },
	surface = { "CursorLine", "Visual", "Pmenu" }, -- read for bg, not fg
	normal = { "String", "@string" },
	visual = { "Function", "@function" },
	replace = { "DiagnosticError", "ErrorMsg" },
	command = { "DiagnosticWarn", "WarningMsg" },
}

-- How far a color recedes toward the backdrop (black on dark schemes, white on
-- light ones). Tuned so that under Vesper these land on the values the palette
-- used to hardcode: text_dim #999999, surface_dim #1e1e1e.
local recede = {
	text = 0.25,
	surface = 0.42,
	block = 0.12, -- blockwise modes, a shade off their charwise base
}

-- Only used if a colorscheme defines none of the anchors above.
local fallback = {
	dark = { text = "#CCCCCC", surface = "#353535", accent = "#82D9C2" },
	light = { text = "#101010", surface = "#DCDCDC", accent = "#3B8C7A" },
}

-- Per-colorscheme escape hatch, keyed by `vim.g.colors_name`. Anything set
-- here wins over the derived value:
--   ["gruvbox-material"] = { insert = "#7daea3" },
local overrides = {}

local function parse(hex)
	local r, g, b = hex:match("^#(%x%x)(%x%x)(%x%x)$")
	if not r then
		return nil
	end
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end

local function mix(from, to, amount)
	local r1, g1, b1 = parse(from)
	local r2, g2, b2 = parse(to)
	if not r1 or not r2 then
		return from
	end
	local function blend(a, b)
		return math.floor(a + (b - a) * amount + 0.5)
	end
	return string.format("#%02x%02x%02x", blend(r1, r2), blend(g1, g2), blend(b1, b2))
end

-- Rough perceptual distance. Only used to answer "would these two mode blocks
-- look like the same block?", which plain RGB distance is bad at.
local function distance(a, b)
	local r1, g1, b1 = parse(a)
	local r2, g2, b2 = parse(b)
	if not r1 or not r2 then
		return math.huge
	end
	return math.sqrt(2 * (r1 - r2) ^ 2 + 4 * (g1 - g2) ^ 2 + 3 * (b1 - b2) ^ 2)
end

-- Two modes sharing a color are two modes you cannot tell apart, and lean
-- schemes do reuse one color across the groups we borrow from -- gruvbox-material
-- defines Function and String identically, rose-pine String and DiagnosticWarn.
-- Nudge a clashing color toward the backdrop until it reads as its own shade.
--
-- The threshold is deliberately low: it separates colors that are effectively
-- the same, and leaves merely-similar ones alone. Vesper's visual and command
-- really are two neighbouring peaches, and that is the scheme's call to make.
local MIN_DISTANCE = 25

local function distinct(color, taken, backdrop)
	local candidate = color
	for step = 0, 3 do
		if step > 0 then
			candidate = mix(color, backdrop, 0.18 * step)
		end
		local clash = false
		for _, t in ipairs(taken) do
			if distance(candidate, t) < MIN_DISTANCE then
				clash = true
				break
			end
		end
		if not clash then
			break
		end
	end
	taken[#taken + 1] = candidate
	return candidate
end

-- WCAG relative luminance, used to decide what stays readable on a given block.
local function luminance(hex)
	local r, g, b = parse(hex)
	if not r then
		return 0
	end
	local function channel(v)
		v = v / 255
		if v <= 0.03928 then
			return v / 12.92
		end
		return ((v + 0.055) / 1.055) ^ 2.4
	end
	return 0.2126 * channel(r) + 0.7152 * channel(g) + 0.0722 * channel(b)
end

local function contrast(a, b)
	local la, lb = luminance(a), luminance(b)
	local hi, lo = math.max(la, lb), math.min(la, lb)
	return (hi + 0.05) / (lo + 0.05)
end

local function attr_of(groups, key)
	for _, name in ipairs(groups) do
		local ok, h = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
		if ok and h and h[key] then
			return string.format("#%06x", h[key])
		end
	end
	return nil
end

-- Foreground of the first group that defines one. Exposed because accents
-- borrow foregrounds the same way the palette does.
function M.fg_of(groups)
	return attr_of(groups, "fg")
end

-- Whichever of ink/paper stays legible on `bg`. This is what lets a light
-- colorscheme (or a dark accent like github_light's purple Function) keep a
-- readable mode block without any per-scheme tuning.
function M.readable(bg)
	if not bg or not parse(bg) then
		return INK
	end
	return contrast(bg, INK) >= contrast(bg, PAPER) and INK or PAPER
end

local function derive()
	local dark = vim.o.background == "dark"
	local backdrop = dark and "#000000" or "#FFFFFF"
	local default = dark and fallback.dark or fallback.light

	local text = M.fg_of(anchors.text) or default.text
	local muted = M.fg_of(anchors.muted) or text
	local surface = attr_of(anchors.surface, "bg") or default.surface
	local visual = M.fg_of(anchors.visual) or default.accent

	-- Claimed in priority order: whatever comes first keeps the scheme's color
	-- untouched, and later modes shift only if they would be indistinguishable.
	-- Sequential, not a table constructor: `distinct` claims as it goes, and
	-- Lua leaves constructor field order undefined.
	local taken = {}
	local normal = distinct(M.fg_of(anchors.normal) or default.accent, taken, backdrop)
	-- Comment is a neutral grey in every scheme, which is the character insert
	-- mode wants; lifted toward the text color so it reads as a block rather
	-- than as dimmed-out text.
	local insert = distinct(mix(muted, text, 0.35), taken, backdrop)
	local visual_mode = distinct(visual, taken, backdrop)
	local replace = distinct(M.fg_of(anchors.replace) or default.accent, taken, backdrop)
	local command = distinct(M.fg_of(anchors.command) or default.accent, taken, backdrop)

	local p = {
		text = text,
		text_dim = mix(text, backdrop, recede.text),
		surface = surface,
		surface_dim = mix(surface, backdrop, recede.surface),

		normal = normal,
		insert = insert,
		visual = visual_mode,
		-- Shaded off the settled visual, so it stays a sibling of whatever
		-- visual ended up being rather than of the scheme's raw Function.
		visual_block = mix(visual_mode, backdrop, recede.block),
		replace = replace,
		command = command,
	}

	return vim.tbl_extend("force", p, overrides[vim.g.colors_name] or {})
end

-- Resolved lazily and cached: the colorscheme is applied after this module is
-- first required, and re-deriving on every redraw would mean a pile of
-- nvim_get_hl calls per keystroke.
local cache

function M.get()
	if not cache then
		cache = derive()
	end
	return cache
end

-- Dropping the cache is enough: the segment highlight groups are redefined on
-- the next redraw anyway, which is also what makes them survive the `hi clear`
-- that :colorscheme performs.
local function invalidate()
	cache = nil
end

local group = vim.api.nvim_create_augroup("StatuslinePalette", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	desc = "Re-derive the statusline palette from the new colorscheme",
	callback = invalidate,
})

-- Separate, because OptionSet with pattern "*" would fire on every option
-- assignment -- including the `statusline` this module's own autocmds set.
vim.api.nvim_create_autocmd("OptionSet", {
	group = group,
	pattern = "background",
	desc = "Re-derive the statusline palette when flipping dark/light",
	callback = invalidate,
})

return M
