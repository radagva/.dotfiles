local gh = require("config.utils").gh

vim.pack.add({ gh("datsfilipe/vesper.nvim") })

require("vesper").setup({
	transparent = true,
	overrides = {
		NormalFloat = { bg = "none" },
	},
})
