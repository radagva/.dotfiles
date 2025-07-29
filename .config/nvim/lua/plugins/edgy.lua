return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = {
		animate = {
			enabled = false,
		},
		bottom = {
			-- {
			-- 	title = "DB Query Result",
			-- 	ft = "dbout",
			-- 	width = 5.0,
			-- },
			-- {
			-- 	title = "Terminal",
			-- 	ft = "terminal",
			-- 	width = 5.0,
			-- },
			-- {
			-- 	title = "DapView",
			-- 	ft = "dap-view",
			-- 	width = 5.0,
			-- },
		},
		right = {
			-- {
			-- 	title = "Database",
			-- 	ft = "dbui",
			-- 	pinned = false,
			-- 	width = 0.3,
			-- 	open = function()
			-- 		vim.cmd("DBUI")
			-- 	end,
			-- },
		},
		left = {
			-- {
			-- 	title = "Fyler",
			-- 	ft = "fyler",
			-- 	size = { height = 0.5 },
			-- },
			-- {
			-- 	title = "Neo-Tree",
			-- 	ft = "neo-tree",
			-- 	filter = function(buf)
			-- 		return vim.b[buf].neo_tree_source == "filesystem"
			-- 	end,
			-- },
			-- {
			-- 	title = "Scopes",
			-- 	ft = "dapui_scopes",
			-- },
			-- {
			-- 	title = "Breakpoints",
			-- 	ft = "dapui_breakpoints",
			-- },
			-- {
			-- 	title = "Stacks",
			-- 	ft = "dapui_stacks",
			-- },
		},
	},
}
