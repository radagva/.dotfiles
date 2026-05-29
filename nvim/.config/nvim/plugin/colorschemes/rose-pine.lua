local github = require("config.utils").github
local highlights = require("config.utils").highlights

vim.pack.add({ { src = github("rose-pine/neovim"), name = "rose-pine" } })

require("rose-pine").setup({
	styles = {
		bold = true,
		italic = true,
		transparency = true,
	},
	highglight_groups = highlights({}),
})
