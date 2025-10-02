return {
	{
		"mgierada/lazydocker.nvim",
		dependencies = { "akinsho/toggleterm.nvim", "folke/which-key.nvim" },
		config = function()
			require("lazydocker").setup({
				border = "curved",
			})
		end,
		event = "BufRead",
		init = function()
			require("which-key").add({
				{
					"<leader>ld",
					function()
						require("lazydocker").open()
					end,
					desc = "Open Lazydocker",
				},
			})
		end,
		-- keys = {
		-- 	{
		-- 		"<leader>k",
		-- 		function()
		-- 			require("lazydocker").open()
		-- 		end,
		-- 		desc = "Open Lazydocker floating window",
		-- 	},
		-- },
	},
}
