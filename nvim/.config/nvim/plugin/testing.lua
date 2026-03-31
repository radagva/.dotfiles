vim.pack.add({
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-neotest/neotest-python" },
	{ src = "https://github.com/nvim-neotest/neotest-jest" },
	{ src = "https://github.com/marilari88/neotest-vitest" },
	{ src = "https://github.com/nvim-neotest/neotest" },
})

local neotest = require("neotest")

neotest.setup({
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

vim.keymap.set("n", "<leader>t", run, { desc = "Testing" })
vim.keymap.set("n", "<leader>tr", run, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>ta", runall, { desc = "Run all tests of file" })
vim.keymap.set("n", "<leader>td", rundebug, { desc = "Run nearest test with DAP" })
vim.keymap.set("n", "<leader>tq", stoptests, { desc = "Stop testcase" })
vim.keymap.set("n", "<leader>ts", toggletestssummary, { desc = "Toggle tests summary" })
