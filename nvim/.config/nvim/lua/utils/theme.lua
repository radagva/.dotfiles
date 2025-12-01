return function(name)
	local themes = {
		require("themes.catppuccin"),
		require("themes.gruvbox"),
		require("themes.rose-pine"),
		require("themes.kanagawa"),
		require("themes.vague"),
		require("themes.tokyonight"),
		require("themes.gruvbox-material"),
	}

	for _, v in pairs(themes) do
		if v.name == name then
			v.init = function()
				vim.cmd.colorscheme(name)
			end

			v.priority = 1000
			v.lazy = false
		end
	end

	return themes
end
