local M = {}

M.js_filetypes = {
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

M.setup = function(dap)
	setup_node_adapters(dap)

	local current_file = vim.fn.expand("%:t")

	for _, language in ipairs(M.js_filetypes) do
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
					name = "tsx (" .. current_file .. ")",
					type = "node",
					request = "launch",
					program = "${file}",
					runtimeExecutable = "tsx",
					cwd = "${workspaceFolder}",
					console = "integratedTerminal",
					internalConsoleOptions = "neverOpen",
					skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
				},
				{
					name = "---------- launch.json options ----------",
					type = "",
					request = "launch",
				},
			}
		end
	end
end

return M
