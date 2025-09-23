local catppuccin = require("themes.catppuccin")
local gruvbox = require("themes.gruvbox")
local rosepine = require("themes.rose-pine")

return function(name)
	local themes = {}

	table.insert(themes, gruvbox)
	table.insert(themes, catppuccin)
	table.insert(themes, rosepine)

	for _, v in pairs(themes) do
		if v.name == name then
			v.init = function()
				vim.cmd.colorscheme(name)
			end
		end
	end

	return themes
end
