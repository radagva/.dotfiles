-- Every color the statusline uses lives here. Nothing outside this file should
-- mention a hex value or a highlight group name: builders ask for a segment by
-- name and get back an opaque style token they pass along untouched.

local c = require("utils.colors")

local M = {}

local palette = {
	ink = "#101010",
	surface = "#353535",
	surface_dim = "#1e1e1e",
	text = "#CCCCCC",
	text_dim = "#999999",
	mint = "#82D9C2",
	gray = "#A0A0A0",
	peach = "#FFCFA8",
	tan = "#E8B88A",
	red = "#FF8080",
	orange = "#FFC799",
	sky = "#A5D6FF",
}

-- `seam` is the color neighbouring separators taper into. It is usually the
-- segment's own bg, but a segment can opt out with seam = "none" to let the
-- wedges around it disappear into the bar instead of framing it.
local segments = {
	mode = { bg = palette.mint, fg = palette.ink },
	git = { bg = palette.surface, fg = palette.text },
	diag = { bg = palette.surface_dim, fg = palette.text_dim, seam = "none" },
	dap = { bg = palette.surface_dim, fg = palette.text_dim },
	lc = { bg = palette.surface, fg = palette.text },
}

-- Mode backgrounds, keyed the same way `vim.api.nvim_get_mode().mode` reports.
-- "\22" is CTRL-V (visual-block) and "\19" is CTRL-S (select-block).
local mode_bg = {
	n = palette.mint, -- normal
	i = palette.gray, -- insert
	v = palette.peach, -- visual
	["\22"] = palette.tan, -- visual block
	s = palette.peach, -- select char
	S = palette.peach, -- select line
	["\19"] = palette.tan, -- select block
	R = palette.red, -- replace
	c = palette.orange, -- command
	t = palette.mint, -- terminal
}

-- Accents are the flecks of color inside a segment: a branch icon, a diff
-- count, a wifi glyph. `group` borrows another highlight's foreground so the
-- accent tracks the active colorscheme; `color` pins it to the palette. Either
-- way the accent sits on the segment's own background, so the block stays
-- solid behind it.
--
-- `verbatim` opts out of that: the group is used whole, background included.
-- ErrorMsg and WarningMsg are transparent, so the diagnostic counts show the
-- bar through them rather than the segment's bg. Drop `verbatim` to make them
-- match the way the git counts are drawn.
local accents = {
	branch = { group = c.highlights.git_branch },
	added = { group = "GitSignsAdd" },
	changed = { group = "GitSignsChange" },
	removed = { group = "GitSignsDelete" },
	error = { group = "ErrorMsg", verbatim = true },
	warn = { group = "WarningMsg", verbatim = true },
	wifi = { color = palette.sky },
}

local function define(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
	return name
end

local function group_name(segment)
	return "Stl" .. segment:sub(1, 1):upper() .. segment:sub(2)
end

local function style(segment, overrides)
	local spec = segments[segment]
	local opts = { bg = overrides and overrides.bg or spec.bg, fg = spec.fg }
	return {
		hl = define(group_name(segment), opts),
		seam = spec.seam or opts.bg,
	}
end

-- Resolve a highlight group's foreground to a hex string so it can be reused
-- over a segment's background instead of dragging in that group's own bg.
local function fg_hex(group)
	local ok, h = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
	if ok and h and h.fg then
		return string.format("#%06x", h.fg)
	end
	return nil
end

-- Style token for a fixed segment. Callers treat the result as opaque.
function M.segment(name)
	return style(name)
end

-- Style token for the mode segment, tinted for the mode Neovim is in.
function M.mode(mode)
	return style("mode", { bg = mode_bg[mode] or mode_bg.n })
end

-- Transparent group, used to stop the padding region between the two chains
-- from inheriting (and stretching) the previous segment's background.
function M.fill()
	return define("StlFill", { bg = "none" })
end

-- A separator triangle: its fg is the segment it grows out of, its bg the
-- neighbour it points into, so adjacent blocks meet with no gap.
function M.wedge(from, to, text)
	return c.exthl({ fg = from, bg = to }, text)
end

-- Render `text` in an accent's color over `segment`'s background.
function M.accent(segment, name, text)
	if text == "" then
		return ""
	end
	local accent = accents[name]
	if accent.verbatim then
		return c.hl(accent.group, text)
	end
	local fg = accent.color or fg_hex(accent.group)
	return c.exthl({ fg = fg, bg = segments[segment].bg }, text)
end

return M
