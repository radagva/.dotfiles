return {
	settings = {
		pyright = {
			codeActions = {
				source = {
					addMissingImports = true,
				},
			},
		},
		basedpyright = {
			analysis = {
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
			},
		},
	},
}
