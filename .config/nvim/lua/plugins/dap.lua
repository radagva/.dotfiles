local js_filetypes = {
	"typescript",
	"javascript",
	"typescriptreact",
	"javascriptreact",
}

local setup_node_adapters = function(dap)
	if not dap.adapters["pwa-node"] then
		require("dap").adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = {
					vim.fn.stdpath("data") .. "/mason/packages" .. "/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}",
				},
			},
		}
	end

	if not dap.adapters["node"] then
		dap.adapters["node"] = function(cb, config)
			if config.type == "node" then
				config.type = "pwa-node"
			end
			local nativeAdapter = dap.adapters["pwa-node"]
			if type(nativeAdapter) == "function" then
				nativeAdapter(cb, config)
			else
				cb(nativeAdapter)
			end
		end
	end
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"mxsdev/nvim-dap-vscode-js",
		},
		config = function()
			local dap, widgets = require("dap"), require("dap.ui.widgets")

			setup_node_adapters(dap)

			-- local current_file = vim.fn.expand("%:t")

			for _, language in ipairs(js_filetypes) do
				if not dap.configurations[language] then
					dap.configurations[language] = {
						{
							type = "pwa-node",
							request = "launch",
							name = "Launch file",
							program = "${file}",
							cwd = "${workspaceFolder}",
						},
						{
							type = "pwa-node",
							request = "attach",
							name = "Attach",
							processId = require("dap.utils").pick_process,
							cwd = "${workspaceFolder}",
						},
						{
							name = "---------- launch.json options ----------",
							type = "",
							request = "launch",
						},
						-- {
						-- 	name = "tsx (" .. current_file .. ")",
						-- 	type = "node",
						-- 	request = "launch",
						-- 	program = "${file}",
						-- 	runtimeExecutable = "tsx",
						-- 	cwd = "${workspaceFolder}",
						-- 	console = "integratedTerminal",
						-- 	internalConsoleOptions = "neverOpen",
						-- 	skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
						-- },
					}
				end
			end

			local sign = vim.fn.sign_define

			--when breakpoint is hit, it sets the focus to the buffer with the breakpoint
			dap.defaults.fallback.switchbuf = "usetab,uselast"

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
			-- dap.listeners.before.event_terminated.dapui_config = function()
			-- 	vim.cmd("DapViewClose")
			-- end
			-- dap.listeners.before.event_exited.dapui_config = function()
			-- 	vim.cmd("DapViewCloset")
			-- end

			vim.keymap.set("n", "<leader>du", ":DapViewToggle<CR>", { desc = "Toggle DapView" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dap-go").setup()
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
