return {
	"mgierada/lazydocker.nvim",
	dependencies = { "akinsho/toggleterm.nvim" },
	config = function()
		require("lazydocker").setup({
			border = "curved", -- valid options are "single" | "double" | "shadow" | "curved"
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
}
-- return {
--   'crnvl96/lazydocker.nvim',
--   opts = {
--     window = {
--       settings = {
--         width = 0.818,       -- Percentage of screen width (0 to 1)
--         height = 0.818,      -- Percentage of screen height (0 to 1)
--         border = 'rounded',  -- See ':h nvim_open_win' border options
--         relative = 'editor', -- See ':h nvim_open_win' relative options
--       },
--     },
--   },
--   keys = {
--     { "<leader>k", '<cmd>lua LazyDocker.toggle()<cr>', desc = 'Toggle lazydocker' }
--   }
-- }
