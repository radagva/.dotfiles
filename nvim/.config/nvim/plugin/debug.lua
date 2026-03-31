vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap", name = "dap" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui", name = "dapui" },
	{ src = "https://github.com/mfussenegger/nvim-dap-python" },
	{ src = "https://github.com/mxsdev/nvim-dap-vscode-js" },
	{ src = "https://github.com/leoluz/nvim-dap-go" },
})

local dap, widgets, dapui, dapgo, dappython =
	require("dap"), require("dap.ui.widgets"), require("dapui"), require("dap-go"), require("dap-python")

dap.defaults.fallback.switchbuf = "usetab,uselast"

-- javascript.setup(dap)

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

dappython.setup("uv")
dapgo.setup()

dapui.setup({
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

dap.listeners.before.attach.dapui_config = dapui.open
dap.listeners.before.launch.dapui_config = dapui.open
dap.listeners.before.event_terminated.dapui_config = dapui.close
dap.listeners.before.event_exited.dapui_config = dapui.close

vim.keymap.set("n", "<leader>d", "", { desc = "Debug" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", silent = true })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", silent = true })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate", silent = true })
vim.keymap.set("n", "<leader>dh", function(val)
	widgets.hover(val, { border = "rounded" })
end, { desc = "Hover", silent = true })

vim.keymap.set("n", "<leader>du", function()
	dapui.toggle({ reset = true })
end, { desc = "Toggle DAP UI" })
