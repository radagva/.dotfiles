local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ github("vague-theme/vague.nvim") })

require("vague").setup({
	transparent = true,
	on_highlights = function(hl, _)
		highlights(hl)
	end,
})
