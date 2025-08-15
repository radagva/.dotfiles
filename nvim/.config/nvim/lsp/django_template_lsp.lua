-- local function get_djangolsp_path()
-- 	local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
-- 	return mason_path .. "/angular-language-server/node_modules/@angular/language-server/index.js"
-- end

return {
	cmd = { "djlsp" },
	-- cmd = { vim.fn.stdpath("data") .. "/mason/packages/django-template-lsp/.venv/bin/djlsp" },
	-- cmd = { "django-template-lsp" },
	filetypes = { "htmldjango" },
	root_markers = { "manage.py", ".git" },
	init_options = {
		-- django_settings_module = "<your.settings.module>",
		-- docker_compose_file = "docker-compose.yml",
		-- docker_compose_service = "django",
	},
}
