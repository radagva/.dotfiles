local util = require("lspconfig.util")

return {
	filetypes = { "typescript", "html", "htmlangular" },
	root_markers = { "angular.json", "nx.json" },
	default_config = {
		root_dir = util.root_pattern("angular.json"),
	},
}
