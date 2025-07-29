return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			python = { "ruff_format", "ruff_fix" },
			go = { "gofumpt" },
			sql = { "sql_formatter" },
			["*"] = { "injected" }, -- enables injected-lang formatting for all filetypes
		},
		-- formatters = {
		-- 	gofumpt = {
		-- 		command = "gofumpt",
		-- 		args = { "$FILENAME" },
		-- 		stdin = false,
		-- 	},
		-- },
		format_on_save = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
	},
}
