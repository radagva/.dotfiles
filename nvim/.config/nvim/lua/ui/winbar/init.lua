local filepath = require("ui.winbar.filepath")

local winbar_filetype_exclude = {
	[""] = true,
	["NvimTree"] = true,
	["Outline"] = true,
	["Trouble"] = true,
	["alpha"] = true,
	["dashboard"] = true,
	["lir"] = true,
	["neo-tree"] = true,
	["snacks_picker"] = true,
	["snacks_picker_list"] = true,
	["snacks_picker_input"] = true,
	["snacks_picker_preview"] = true,
	["fugitive"] = true,
	["neotest-summary"] = true,
}

Winbar = {}

function Winbar.activate()
	return " "
		.. table.concat({
			filepath(),
			-- "%f",
			"%m",
		}, " ")
		.. " "
end

function Winbar.deactivate()
	vim.opt_local.winbar = ""
end

local group = vim.api.nvim_create_augroup("Winbar", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = group,
	desc = "Activate winbar on focus",
	callback = function()
		local current_ft = vim.bo.filetype
		if winbar_filetype_exclude[current_ft] then
			return Winbar.deactivate()
		end

		vim.opt_local.winbar = "%!v:lua.Winbar.activate()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = group,
	desc = "Deactivate winbar when unfocused",
	callback = function()
		Winbar.deactivate()
	end,
})
