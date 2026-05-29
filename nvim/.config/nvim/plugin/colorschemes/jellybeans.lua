local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ github("wtfox/jellybeans.nvim") })

require("jellybeans").setup({
	transparent = true,
	background = {
		dark = "jellybeans", -- default dark palette
		light = "jellybeans", -- default light palette
	},
	on_highlights = function(hl, _)
		highlights(hl)
	end,
})
