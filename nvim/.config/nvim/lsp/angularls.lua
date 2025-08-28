local function get_angularls_path()
	local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
	return mason_path .. "/angular-language-server/node_modules/@angular/language-server/index.js"
end

local angularls_path = get_angularls_path()

local function get_probe_dir(root_dir)
	local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])

	return project_root and (project_root .. "/node_modules") or ""
end

local function get_angular_core_version(root_dir)
	local project_root = vim.fs.dirname(vim.fs.find("node_modules", { path = root_dir, upward = true })[1])

	if not project_root then
		return ""
	end

	local package_json = project_root .. "/package.json"
	if not vim.uv.fs_stat(package_json) then
		return ""
	end

	local contents = io.open(package_json):read("*a")
	local json = vim.json.decode(contents)
	if not json.dependencies then
		return ""
	end

	local angular_core_version = json.dependencies["@angular/core"]

	angular_core_version = angular_core_version and angular_core_version:match("%d+%.%d+%.%d+")

	return angular_core_version
end

local ts_probe = get_probe_dir(vim.fn.getcwd())
local ng_probe = table.concat({ angularls_path .. "/node_modules/@angular/language-server", vim.fn.getcwd() }, ",")
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	ts_probe,
	"--ngProbeLocations",
	ng_probe,
	"--angularCoreVersion",
	default_angular_core_version,
}

---@type vim.lsp.Config
return {
	name = "angularls",
	cmd = cmd,
	filetypes = { "html", "ts" },
	root_markers = { "angular.json" },
	on_new_config = function(new_config, new_root_dir)
		local new_probe_dir = get_probe_dir(new_root_dir)
		local angular_core_version = get_angular_core_version(new_root_dir)

		-- We need to check our probe directories because they may have changed.
		new_config.cmd = {
			vim.fn.exepath("ngserver"),
			"--stdio",
			"--tsProbeLocations",
			new_probe_dir,
			"--ngProbeLocations",
			new_probe_dir,
			"--angularCoreVersion",
			angular_core_version,
		}
	end,
	-- on_new_config = function(new_config)
	-- 	new_config.cmd = cmd
	-- end,
	capabilities = vim.lsp.protocol.make_client_capabilities(),
	settings = {
		angular = {
			suggest = {
				standalone = false,
			},
		},
	},
}
