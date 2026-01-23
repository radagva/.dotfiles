local modes = {
	n = "NORMAL",
	no = "O-PENDING",
	v = "VISUAL",
	V = "V-LINE",
	[""] = "V-BLOCK",
	s = "SELECT",
	S = "S-LINE",
	[""] = "S-BLOCK",
	i = "INSERT",
	R = "REPLACE",
	c = "COMMAND",
	t = "TERMINAL",
}

return function()
	local mode = vim.api.nvim_get_mode().mode
	return string.format("[%s]", modes[mode] or mode)
end
