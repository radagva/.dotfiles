vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/saghen/blink.cmp", version = "v1.10.1" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/tpope/vim-dotenv" },
	{ src = "https://github.com/windwp/nvim-ts-autotag" },
	{ src = "https://github.com/dmmulroy/tsc.nvim" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/benomahony/uv.nvim" },
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" },
})

local mason, blink, treesitter, conform, tsautotag, tsc, lazydev, uv, colorizer =
	require("mason"),
	require("blink.cmp"),
	require("nvim-treesitter"),
	require("conform"),
	require("nvim-ts-autotag"),
	require("tsc"),
	require("lazydev"),
	require("uv"),
	require("colorizer")

colorizer.setup({
	"*",
}, { mode = "background" })

uv.setup({
	picker_integration = true,
	auto_activate_venv = true,
	notify_activate_venv = true,
	keymaps = false,
})

lazydev.setup({
	library = { "nvim-dap-ui" },
})

tsc.setup({
	use_trouble_qflist = true,
})

tsautotag.setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
	-- Also override individual filetype configs, these take priority.
	-- Empty by default, useful if one of the "opts" global settings
	-- doesn't work well in a specific filetype
	per_filetype = {
		["html"] = {
			enable_close = false,
		},
	},
})

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "prettier", "biome" },
		javascriptreact = { "prettier", "biome" },
		typescript = { "prettier", "biome" },
		typescriptreact = { "prettier", "biome" },
		astro = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		python = { "ruff_format", "ruff_fix", "isort" },
		go = { "gofumpt" },
		sql = { "sql_formatter" },
		cpp = { "clang-format" },
		-- ["*"] = { "injected" },
	},
	notify_on_error = false,
	format_on_save = function(bufnr)
		return {
			timeout_ms = 500,
			lsp_format = "never",
		}
	end,
})

treesitter.setup({
	modules = {},
	ensure_installed = {
		"lua",
		"go",
		"bash",
		"html",
		"css",
		"typescript",
		"tsx",
		"http",
		"sql",
		-- config files
		"json",
		"yaml",
		"toml",
		"c",
		"markdown",
	},
	sync_install = false,
	auto_install = true,
	ignore_install = { "some_parser" },
	highlight = {
		enable = true,
		disable = { "help" },
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true },
	incremental_selection = { enable = true },
	textobjects = { enable = true },
})

-- vim.api.nvim_create_autocmd("FileType", {
-- 	-- pattern = { "*" },
-- 	callback = function()
-- 		vim.treesitter.start()
-- 	end,
-- })

mason.setup({
	ensure_installed = { "http", "c", "css-lsp" },
	ui = {
		border = "rounded",
	},
})

blink.setup({
	keymap = { preset = "default" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = {
				border = "rounded",
			},
		},
		menu = {
			border = "rounded",
			draw = {
				columns = {
					{ "item_idx" },
					{ "label", "label_description", gap = 2 },
					{ "kind_icon" },
					{ "kind" },
				},
				components = {
					label_description = {
						highlight = "PMenu",
					},
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
					},
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path" },
		per_filetype = {
			sql = { "dadbod" },
		},
		providers = {
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			path = {
				enabled = function()
					return vim.bo.filetype ~= "copilot-chat"
				end,
			},
		},
	},
	-- fuzzy = { implementation = "prefer_rust" },
	fuzzy = { implementation = "lua" },
})
