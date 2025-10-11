return {
	"folke/snacks.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {
			configure = true,
		},
		bigfile = { enabled = true },
		picker = {
			enabled = true,
			-- ui_select = true,
			-- layout = { preset = "ivy" },
			-- sources = {
			-- 	explorer = {
			-- 		cycle = true,
			-- 		auto_close = true,
			-- 		layout = { preview = "main" },
			-- 	},
			-- },
			-- layout = {
			-- 	{ preview = true },
			-- 	layout = {
			-- 		box = "horizontal",
			-- 		width = 0.8,
			-- 		height = 0.8,
			-- 		{
			-- 			box = "vertical",
			-- 			border = "rounded",
			-- 			title = "{source} {live} {flags}",
			-- 			title_pos = "center",
			-- 			{ win = "input", height = 1, border = "bottom" },
			-- 			{ win = "list", border = "none" },
			-- 		},
			-- 		{ win = "preview", border = "rounded", width = 0.7, title = "{preview}" },
			-- 	},
			-- },
		},
		explorer = {
			enabled = true,
		},
	},
	init = function()
		require("which-key").add({
			{
				"<leader>e",
				function()
					Snacks.explorer.open()
				end,
				desc = "Show explorer",
				silent = true,
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit.open()
				end,
				desc = "Open lazygit",
			},
		})
	end,
}
