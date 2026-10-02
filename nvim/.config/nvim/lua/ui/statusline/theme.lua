-- Every color the statusline uses lives here. Nothing outside this file should
-- mention a hex value or a highlight group name: builders ask for a segment by
-- name and get back an opaque style token they pass along untouched.
--
-- The colors themselves come from `palette`, which reads them off the active
-- colorscheme. This file only decides what goes where.

local c = require("utils.colors")
local palette = require("ui.statusline.palette")

local M = {}

-- `seam` is the color neighbouring separators taper into. It is usually the
-- segment's own bg, but a segment can opt out with seam = "none" to let the
-- wedges around it disappear into the bar instead of framing it.
--
-- `contrast` means the fg is picked from the bg for legibility rather than
-- fixed: the mode block's bg changes with the mode, and on a light colorscheme
-- it needs light text.
local function specs()
	local p = palette.get()
	return {
		mode = { bg = p.normal, contrast = true },
		git = { bg = p.surface, fg = p.text },
		diag = { bg = p.surface_dim, fg = p.text_dim, seam = "none" },
		dap = { bg = p.surface_dim, fg = p.text_dim },
		lsp = { bg = p.surface_dim, fg = p.text_dim },
		flutterapp = { bg = p.surface_dim, fg = p.text_dim },
		flutterdevice = { bg = p.surface, fg = p.text },
		lc = { bg = p.surface, fg = p.text },
	}
end

-- Mode backgrounds, keyed the same way `vim.api.nvim_get_mode().mode` reports.
-- "\22" is CTRL-V (visual-block) and "\19" is CTRL-S (select-block).
local function mode_bg()
	local p = palette.get()
	return {
		n = p.normal, -- normal
		i = p.insert, -- insert
		v = p.visual, -- visual
		["\22"] = p.visual_block, -- visual block
		s = p.visual, -- select char
		S = p.visual, -- select line
		["\19"] = p.visual_block, -- select block
		R = p.replace, -- replace
		c = p.command, -- command
		t = p.normal, -- terminal
	}
end

-- Accents are the flecks of color inside a segment: a branch icon, a diff
-- count, a wifi glyph. Each borrows the foreground of the first group listed
-- that the colorscheme actually defines, so accents follow the scheme too, and
-- each sits on the segment's own background so the block stays solid behind it.
local accents = {
	branch = { groups = { c.highlights.git_branch, "Function" } },
	added = { groups = { "GitSignsAdd", "DiagnosticOk", "String" } },
	changed = { groups = { "GitSignsChange", "DiagnosticWarn" } },
	removed = { groups = { "GitSignsDelete", "DiagnosticError" } },
	error = { groups = { "ErrorMsg", "DiagnosticError" } },
	warn = { groups = { "WarningMsg", "DiagnosticWarn" } },
	wifi = { groups = { c.highlights.wifi, "Constant" } },
	dart = { groups = { c.highlights.dart, "Type" } },
	device = { groups = { c.highlights.device, "Constant" } },
}

local function define(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
	return name
end

local function group_name(segment)
	return "Stl" .. segment:sub(1, 1):upper() .. segment:sub(2)
end

local function style(segment, bg)
	local spec = specs()[segment]
	local opts = { bg = bg or spec.bg }
	opts.fg = spec.contrast and palette.readable(opts.bg) or spec.fg

	return {
		hl = define(group_name(segment), opts),
		-- `bg` is the block's own color, used as the fg of the wedge growing
		-- out of it. `seam` is what neighbours taper into: normally the same,
		-- but seam = "none" lets them point at the bar instead -- the wedge
		-- leaving the segment must still be painted in the block's colour.
		bg = opts.bg,
		seam = spec.seam or opts.bg,
	}
end

-- Style token for a fixed segment. Callers treat the result as opaque.
function M.segment(name)
	return style(name)
end

-- Style token for the mode segment, tinted for the mode Neovim is in.
function M.mode(mode)
	local bg = mode_bg()
	return style("mode", bg[mode] or bg.n)
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
	return c.exthl({ fg = palette.fg_of(accent.groups), bg = specs()[segment].bg }, text)
end

return M
