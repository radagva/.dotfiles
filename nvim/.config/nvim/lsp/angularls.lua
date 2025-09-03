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
local ng_probe = angularls_path .. "/node_modules/@angular/language-server"
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

local is_angular_template = function()
	local angular_json = vim.fs.find("angular.json", { upward = true })[1]
	if not angular_json then
		return false
	end

	-- Check if the file contains Angular-specific syntax
	local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")

	-- Look for Angular template syntax patterns
	local angular_patterns = {
		"*ngIf=",
		"*ngFor=",
		"{{.*}}",
		"[(ngModel)]=",
		"[.*]=",
		"(.*)=",
		"#.*=",
		"@.*=",
	}

	for _, pattern in ipairs(angular_patterns) do
		if content:match(pattern) then
			return true
		end
	end

	return false
end

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
	on_new_config = function(new_config)
		new_config.cmd = cmd
	end,
	on_attach = function()
		vim.filetype.add({
			pattern = {
				[".*%.component%.html"] = "htmlangular",
			},
			extension = {
				html = function()
					if is_angular_template() then
						return "htmlangular"
					end
					return "html"
				end,
			},
		})

		if vim.bo.filetype == "html" and is_angular_template() then
			vim.bo.filetype = "htmlangular"
		end
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
