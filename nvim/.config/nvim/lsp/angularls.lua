local function get_angularls_path()
	local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
	return mason_path .. "/angular-language-server/node_modules/@angular/language-server/index.js"
end

local angularls_path = get_angularls_path()

local ts_probe = table.concat({
	angularls_path,
	vim.uv.cwd(),
}, ",")

local ng_probe = table.concat({
	angularls_path .. "/node_modules/@angular/language-server",
	vim.uv.cwd(),
}, ",")

local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	ts_probe,
	"--ngProbeLocations",
	ng_probe,
}

---@type vim.lsp.Config
return {
	name = "angularls",
	cmd = cmd,
	filetypes = { "html", "ts" },
	root_markers = { "angular.json" },
	on_new_config = function(new_config)
		new_config.cmd = cmd
	end,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		angular = {
			suggest = {
				standalone = false,
			},
		},
	},
}
