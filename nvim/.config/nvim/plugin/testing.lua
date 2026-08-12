local gh = require("config.utils").gh

vim.pack.add({
	gh("nvim-neotest/nvim-nio"),
	gh("nvim-lua/plenary.nvim"),
	gh("antoinemadec/FixCursorHold.nvim"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("nvim-neotest/neotest-python"),
	gh("nvim-neotest/neotest-jest"),
	gh("marilari88/neotest-vitest"),
	gh("nvim-neotest/neotest"),
	gh("radagva/neotest-dart", { version = "monorepo-support" }),
})

local neotest = require("neotest")

neotest.setup({
	summary = {
		open = "botright vsplit | vertical resize 80",
	},
	-- `workspace` returns one adapter per package in the monorepo, so the summary
	-- gets a section per app/package instead of a single tree for the whole
	-- repository. Outside a Dart project it falls back to a single adapter.
	adapters = vim.list_extend(
		{
			require("neotest-python"),
			require("neotest-jest"),
			require("neotest-vitest"),
			require("neotest-dart"),
		},
		{}
		-- require("neotest-dart").workspace({
		-- 	command = "flutter",
		-- 	use_lsp = true,
		-- 	custom_test_method_names = {},
		-- })
	),
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
