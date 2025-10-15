return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		init = function()
			vim.api.nvim_create_user_command("LoadLastSession", function()
				require("persistence").load()
			end, { desc = "Load last saved session in persistence" })
		end,
	},

	{
		"gbprod/yanky.nvim",
		opts = {
			highlight = {
				timer = 150,
			},
		},
	},
}
