return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		-- dashboard = { enabled = true },
		-- explorer = { enabled = true },
		-- indent = { enabled = true },
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
		-- input = { enabled = true },
		picker = { enabled = true },
		-- notifier = { enabled = true },
		-- quickfile = { enabled = true },
		-- scope = { enabled = true },
		-- scroll = { enabled = true },
		-- statuscolumn = { enabled = true },
		-- words = { enabled = true },
	},
	keys = {
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			{ desc = "Git Current File History" },
		},
		{
			"<leader>gb",
			function()
				Snacks.picker.git_log_line()
			end,
			{ desc = "Git Blame Line" },
		},
	},
}
