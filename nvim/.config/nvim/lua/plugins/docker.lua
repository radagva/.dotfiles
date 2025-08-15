return {
	{
		"mgierada/lazydocker.nvim",
		dependencies = { "akinsho/toggleterm.nvim" },
		config = function()
			require("lazydocker").setup({
				border = "curved",
			})
		end,
		event = "BufRead",
		keys = {
			{
				"<leader>k",
				function()
					require("lazydocker").open()
				end,
				desc = "Open Lazydocker floating window",
			},
		},
	},
}
