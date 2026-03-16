local modes = {
	n = "\u{e6ae} normal",
	-- no = "\u{db86}\u{dd78}",
	v = "\u{f07e} visual",
	-- V = "\u{db81}\u{dde7}",
	[""] = "\u{f07d} visual-block",
	s = "SELECT",
	S = "S-LINE",
	[""] = "S-BLOCK",
	i = "\u{f11c} insert",
	R = "REPLACE",
	c = "\u{f120} command",
	t = "TERMINAL",
}

return function()
	local mode = vim.api.nvim_get_mode().mode
	return string.format("%s ", modes[mode] or mode)
end
