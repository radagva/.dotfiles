local javascript = require("extensions.debugging.javascript")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap, widgets = require("dap"), require("dap.ui.widgets")
			dap.defaults.fallback.exception_breakpoints = { "raised" }

			-- when breakpoint is hit, it sets the focus to the buffer with the breakpoint
			dap.defaults.fallback.switchbuf = "usetab,uselast"

			javascript.setup(dap)

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
			sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue/Start" })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate" })
			vim.keymap.set("n", "<leader>dh", widgets.hover, { desc = "Hover" })
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		dependencies = { "mfussenegger/nvim-dap" },
		lazy = false,
		opts = {
			winbar = {
				sections = { "console", "repl", "scopes", "breakpoints", "watches", "exceptions", "threads" },
				default_section = "scopes",
			},
		},
		init = function()
			local dap = require("dap")

			dap.listeners.before.attach.dapui_config = function()
				vim.cmd("DapViewOpen")
			end
			dap.listeners.before.launch.dapui_config = function()
				vim.cmd("DapViewOpen")
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				vim.cmd("DapViewClose")
			end
			dap.listeners.before.event_exited.dapui_config = function()
				vim.cmd("DapViewClose")
			end

			vim.keymap.set("n", "<leader>du", ":DapViewToggle<cr>", { desc = "Toggle DapView", silent = true })
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-python").setup("uv")
		end,
	},
}
