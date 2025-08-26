---@type vim.lsp.Config
return {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
	root_markers = { "package.json", ".git" },
	settings = {
		css = { validate = true },
	},
}
