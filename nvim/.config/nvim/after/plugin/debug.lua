local dap = require("dap")

dap.defaults.fallback.switchbuf = "usetab,uselast"

dap.configurations.dart = {}
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

require("dap-python").setup("uv")
require("dap-go").setup()

dap.adapters.dart = {
	type = "executable",
	command = "flutter",
	args = { "debug-adapter" },
}

-- dap.listeners.before.attach.dapui_config = dapview.open
-- dap.listeners.before.launch.dapui_config = dapview.open
-- dap.listeners.before.event_terminated.dapui_config = dapview.close
-- dap.listeners.before.event_exited.dapui_config = dapview.close

require("dap-view").setup({
	winbar = {
		controls = {
			enabled = true,
		},
	},
})

vim.keymap.set("n", "<leader>d", "", { desc = "Debug" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue", silent = true })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint", silent = true })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Terminate", silent = true })
vim.keymap.set("n", "<leader>dh", function(_val)
	vim.cmd("DapViewHover")
	-- widgets.hover(val, { border = "rounded" })
end, { desc = "Hover", silent = true })

vim.keymap.set("n", "<leader>du", function()
	vim.cmd("DapViewToggle")
end, { desc = "Toggle DAP UI" })
