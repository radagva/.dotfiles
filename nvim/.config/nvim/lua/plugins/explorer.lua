return {
	"stevearc/oil.nvim",
	opts = {
		win_options = {
			winbar = "%{v:lua.require('oil').get_current_dir()}",
		},
		keymaps = {
			["<C-v>"] = {
				callback = function()
					require("oil").select({ vertical = true, close = true })
				end,
				desc = "select_vsplit",
				mode = "n",
			},
			["<C-s>"] = {
				callback = function()
					require("oil").select({ horizontal = true, close = true })
				end,
				desc = "select_vsplit",
				mode = "n",
			},
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
	keys = {
		{ "-", ":Oil<cr>", desc = "Oil" },
	},
}
