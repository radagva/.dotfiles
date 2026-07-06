local modes = {
	n = "\u{e6ae} normal",
	v = "\u{f07e} visual",
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
	return modes[mode] or mode
end
