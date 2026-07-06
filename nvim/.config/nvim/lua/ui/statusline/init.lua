local mode_mod = require("ui.statusline.mode")
local git_mod = require("ui.statusline.git")
local diag_mod = require("ui.statusline.diagnostics")
local dap_mod = require("ui.statusline.dap")

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

local function build_chain(segs)
	if #segs == 0 then return "" end

	local parts = {}

	for i, seg in ipairs(segs) do
		local content = " " .. seg.content .. " "
		content = content:gsub("%%[*]", "%%#" .. seg.hl .. "#")
		table.insert(parts, ("%%#%s#%s"):format(seg.hl, content))

		if i < #segs then
			local conn = hl("StlConn", { fg = seg.bg, bg = "none" })
			table.insert(parts, ("%%#%s#\u{e0b0}"):format(conn))
		end
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
		table.insert(left, { hl = H_STATIC.diag, bg = FADE.diag.bg, content = diag })
	end

	local right = {}

	local dap = dap_mod()
	if dap ~= "" then
		table.insert(right, { hl = H_STATIC.dap, bg = FADE.dap.bg, content = dap })
	end

	table.insert(right, { hl = H_STATIC.lc, bg = FADE.lc.bg, content = "%l:%c" })

	return ""
		.. build_chain(left)
		.. "   %=   "
		.. build_chain(right)
		.. ""
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
