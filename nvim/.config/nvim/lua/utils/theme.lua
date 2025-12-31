--- variant is optional
return function(name, variant)
	local themes = {
		require("themes.catppuccin"),
		require("themes.gruvbox"),
		require("themes.rose-pine"),
		require("themes.kanagawa"),
		require("themes.vague"),
		require("themes.tokyonight"),
		require("themes.gruvbox-material"),
		require("themes.nightfox"),
	}

	for _, v in pairs(themes) do
		if v.name == name then
			v.init = function()
				vim.cmd.colorscheme(variant or name)
			end

			v.priority = 1000
			v.lazy = false
		end

		-- if v.variant ~= nil then
		-- 	vim.cmd.colorscheme()
		-- end
	end

	return themes
end
