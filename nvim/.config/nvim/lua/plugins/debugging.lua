local javascript = require("extensions.debugging.javascript")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
			"folke/which-key.nvim",
		},
		config = function()
			local dap, widgets, wk = require("dap"), require("dap.ui.widgets"), require("which-key")
			dap.defaults.fallback.exception_breakpoints = { "raised" }

			-- when breakpoint is hit, it sets the focus to the buffer with the breakpoint
			dap.defaults.fallback.switchbuf = "usetab,uselast"

			javascript.setup(dap)

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
			sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

			wk.add({
				{ "<leader>d", group = "Debugging" },
				{ "<leader>dc", dap.continue, desc = "Continue" },
				{ "<leader>db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
				{ "<leader>dq", dap.terminate, desc = "Terminate" },
				{ "<leader>dh", widgets.hover, desc = "Hover" },
			})
		end,
	},
	{
		"igorlfs/nvim-dap-view",
		---@module 'dap-view'
		---@type dapview.Config
		dependencies = { "mfussenegger/nvim-dap", "folke/which-key.nvim" },
		lazy = false,
		opts = {
			winbar = {
				sections = { "console", "repl", "scopes", "breakpoints", "watches", "exceptions", "threads" },
				default_section = "scopes",
			},
		},
		init = function()
			local dap, wk = require("dap"), require("which-key")

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

			wk.add({
				{ "<leader>du", ":DapViewToggle<cr>", desc = "Toggle DapView", silent = true },
			})
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
