return {
	"folke/twilight.nvim",
	opts = {},
	keys = {
		{
			"<leader>ute",
			":TwilightEnable<cr>",
			desc = "Enable twilight",
			silent = true,
		},
		{
			"<leader>utd",
			":TwilightDisable<cr>",
			desc = "Disable twilight",
			silent = true,
		},
	},
}
