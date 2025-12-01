return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-python",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	config = function()
		require("neotest").setup({
			summary = {
				open = "botright vsplit | vertical resize 80",
			},
			adapters = {
				require("neotest-python"),
				require("neotest-jest"),
				require("neotest-vitest"),
			},
			floating = {
				border = "rounded",
			},
		})
	end,
	keys = {
		{
			"<leader>tr",
			function()
				require("neotest").run.run()
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tt",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run all test of current file",
		},
		{
			"<leader>td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Run the nearest test with DAP",
		},
		{
			"<leader>tq",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop the current test case",
		},
		{
			"<leader>ts",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Stop the current test case",
		},
	},
}
