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
	init = function()
		local map = vim.keymap.set
		local function run()
			require("neotest").run.run()
		end

		local function runall()
			require("neotest").run.run(vim.fn.expand("%"))
		end

		local function rundebug()
			require("neotest").run.run({ strategy = "dap" })
		end

		local function stoptests()
			require("neotest").run.stop()
		end

		local function toggletestssummary()
			require("neotest").summary.toggle()
		end

		map("n", "<leader>t", run, { desc = "Testing" })
		map("n", "<leader>tr", run, { desc = "Run nearest test" })
		map("n", "<leader>ta", runall, { desc = "Run all tests of file" })
		map("n", "<leader>td", rundebug, { desc = "Run nearest test with DAP" })
		map("n", "<leader>tq", stoptests, { desc = "Stop testcase" })
		map("n", "<leader>ts", toggletestssummary, { desc = "Toggle tests summary" })
	end,
}
