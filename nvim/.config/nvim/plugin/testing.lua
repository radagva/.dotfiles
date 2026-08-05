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
	gh("sidlatau/neotest-dart"),
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
		require("neotest-dart")({
			command = "flutter", -- Command being used to run tests. Defaults to `flutter`
			-- Change it to `fvm flutter` if using FVM
			-- change it to `dart` for Dart only tests
			use_lsp = true, -- When set Flutter outline information is used when constructing test name.
			-- Useful when using custom test names with @isTest annotation
			custom_test_method_names = {},
		}),
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
