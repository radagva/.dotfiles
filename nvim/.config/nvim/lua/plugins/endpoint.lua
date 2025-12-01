return {
	"zerochae/endpoint.nvim",
	dependencies = {
		"folke/snacks.nvim",
		"stevearc/dressing.nvim",
	},
	cmd = { "Endpoint", "EndpointRefresh" },
	opts = {
		ui = {
			show_icons = false,
		},
	},
	keys = {
		{ "<leader>E", ":Endpoint<cr>", desc = "Show list of endpoint", silent = true, noremap = true },
	},
}
