return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		bigfile = { enabled = true },
		picker = { enabled = true },
		explorer = { enabled = true },
		indent = {
			indent = {
				enabled = false,
			},
			chunk = {
				enabled = true,
				char = {
					horizontal = "─",
					vertical = "│",
					corner_top = "╭",
					corner_bottom = "╰",
					arrow = "─",
				},
			},
		},
	},
	keys = {
		{
			"<leader>E",
			function()
				Snacks.explorer.reveal()
			end,
			desc = "Reveal in explorer",
			silent = true,
		},
		{
			"<leader>e",
			function()
				Snacks.explorer.open()
			end,
			desc = "Show explorer",
			silent = true,
		},
	},
}
