local gh = require("config.utils").gh

vim.pack.add({
	gh("mfussenegger/nvim-dap", { name = "dap" }),
	gh("nvim-neotest/nvim-nio"),
	gh("igorlfs/nvim-dap-view", { version = vim.version.range("1.*") }),
	gh("mfussenegger/nvim-dap-python"),
	gh("mxsdev/nvim-dap-vscode-js"),
	gh("leoluz/nvim-dap-go"),
})

local dap, dapview, dapgo, dappython = require("dap"), require("dap-view"), require("dap-go"), require("dap-python")

dap.defaults.fallback.switchbuf = "usetab,uselast"

dap.configurations.dart = {}
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = " ", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" })
sign("DapBreakpointRejected", { text = " ", texthl = "DiagnosticSignError", linehl = "", numhl = "" })
sign("DapStopped", { text = " ", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "" })

dappython.setup("uv")
dapgo.setup()

dap.adapters.dart = {
	type = "executable",
	command = "flutter",
	args = { "debug-adapter" },
}

-- dap.listeners.before.attach.dapui_config = dapview.open
-- dap.listeners.before.launch.dapui_config = dapview.open
-- dap.listeners.before.event_terminated.dapui_config = dapview.close
-- dap.listeners.before.event_exited.dapui_config = dapview.close

dapview.setup({
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
