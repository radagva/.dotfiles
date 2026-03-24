local javascript = require("extensions.debugging.javascript")

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = { "mxsdev/nvim-dap-vscode-js" },
		config = function()
			local dap, widgets = require("dap"), require("dap.ui.widgets")

			dap.defaults.fallback.switchbuf = "usetab,uselast"

			javascript.setup(dap)

			local sign = vim.fn.sign_define

			sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
			sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
			sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

			vim.keymap.set("n", "<leader>d", "", { desc = "Debug" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", silent = true })
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", silent = true })
			vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate", silent = true })
			vim.keymap.set("n", "<leader>dh", function(val)
				widgets.hover(val, { border = "rounded" })
			end, { desc = "Hover", silent = true })
		end,
	},

	{
		"igorlfs/nvim-dap-view",
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
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup()
		end,
	},
}
