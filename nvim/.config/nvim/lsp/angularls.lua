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

-- Angular requires a node_modules directory to probe for @angular/language-service and typescript
-- in order to use your projects configured versions.
-- This defaults to the vim cwd, but will get overwritten by the resolved root of the file.
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

local default_probe_dir = get_probe_dir(vim.fn.getcwd())
local default_angular_core_version = get_angular_core_version(vim.fn.getcwd())

return {
	cmd = {
		"ngserver",
		"--stdio",
		"--tsProbeLocations",
		default_probe_dir,
		"--ngProbeLocations",
		default_probe_dir,
		"--angularCoreVersion",
		default_angular_core_version,
	},
	root_markers = { "angular.json" },
	filetypes = { "typescript", "htmlangular" },

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

		require("which-key").add({
			{ "<leader>ca", group = "Angular" },
			{
				"<leader>cac",
				function()
					require("angular").create_component()
				end,
				desc = "Create Angular component",
			},
			{
				"<leader>cas",
				function()
					require("angular").create_service()
				end,
				desc = "Create Angular service",
			},
			{
				"<leader>cao",
				function()
					require("angular").run_schematic()
				end,
				desc = "Other Angular Schematic",
			},
		})
	end,
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
}
