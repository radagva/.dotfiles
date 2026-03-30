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
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup({
				winopts = {
					-- General window options for all elements
					border = "single", -- Use 'single', 'double', 'round', or 'none'
					-- Set the title position (e.g., 'left', 'center', 'right')
					title_pos = "center",
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25, title = "Scopes" },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						position = "left", -- Or "right"
						size = 40, -- Sets the fixed width of the sidebar to 40 columns
					},
					{
						elements = {
							{ id = "repl", size = 1.0 },
						},
						position = "bottom",
						size = 10,
					},
				},
			})
		end,
		init = function()
			local map = vim.keymap.set
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = dapui.open
			dap.listeners.before.launch.dapui_config = dapui.open
			dap.listeners.before.event_terminated.dapui_config = dapui.close
			dap.listeners.before.event_exited.dapui_config = dapui.close

			map("n", "<leader>du", function()
				dapui.toggle({ reset = true })
			end, { desc = "Toggle DAP UI" })
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
