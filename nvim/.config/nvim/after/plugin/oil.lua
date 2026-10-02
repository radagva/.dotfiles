require("oil").setup({
	win_options = {
		winbar = "%{v:lua.require('oil').get_current_dir()}",
	},
	keymaps = {
		["<CR>"] = {
			"actions.select",
			opts = {
				close = true,
			},
		},
		["<C-s>"] = { "actions.select", opts = { vertical = true, close = true } },
		["<C-h>"] = { "actions.select", opts = { horizontal = true, close = true } },
	},
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
