local util = require("lspconfig.util")

return {
	default_config = {
		root_dir = util.root_pattern("angular.json", "package.json", ".git"),
	},
}
