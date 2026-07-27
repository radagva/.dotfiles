local github = require("config.utils").github

vim.pack.add({ { src = github("catppuccin/nvim"), name = "catppuccin" } })

require("catppuccin").setup({
	flavour = "mocha",
	transparent_background = true,
	float = {
		transparent = true, -- enable transparent floating windows
		solid = false, -- use solid styling for floating windows, see |winborder|
	},
	custom_highlights = function(c)
		return {
			FlutterWidgetGuides = { fg = "#6C7086", bg = "none" },
		}
	end,
})
