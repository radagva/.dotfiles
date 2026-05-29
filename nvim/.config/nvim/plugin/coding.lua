local gh = require("config.utils").github

vim.pack.add({
	{ src = gh("nemanjamalesija/ts-expand-hover.nvim") },
	{ src = gh("mistweaverco/kulala.nvim") },
	{ src = gh("mason-org/mason.nvim") },
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("saghen/blink.cmp"), version = "v1.10.1" },
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("tpope/vim-dotenv") },
	{ src = gh("windwp/nvim-ts-autotag") },
	{ src = gh("dmmulroy/tsc.nvim") },
	{ src = gh("folke/lazydev.nvim") },
	{ src = gh("benomahony/uv.nvim") },
	{ src = gh("catgoose/nvim-colorizer.lua") },
	{ src = gh("MunifTanjim/nui.nvim") },
	{ src = gh("mfussenegger/nvim-dap") },
})

local mason, blink, treesitter, conform, tsautotag, tsc, lazydev, uv, colorizer, kulala, tsexpandhover =
	require("mason"),
	require("blink.cmp"),
	require("nvim-treesitter"),
	require("conform"),
	require("nvim-ts-autotag"),
	require("tsc"),
	require("lazydev"),
	require("uv"),
	require("colorizer"),
	require("kulala"),
	require("ts_expand_hover")

tsexpandhover.setup()

kulala.setup({
	global_keymaps = true,
	global_keymaps_prefix = "<leader>R",
	kulala_keymaps_prefix = "",
})

vim.keymap.set({ "n", "v" }, "<C-r>", function()
	kulala.run()
end)

colorizer.setup({
	filetypes = { "*" },
	options = {
		parsers = {
			tailwind = { enable = true, lsp = true },
			hex = {
				default = true, -- default value for unset format keys (see above)
				rgb = true, -- #RGB (3-digit)
				rgba = true, -- #RGBA (4-digit)
				rrggbb = true, -- #RRGGBB (6-digit)
				rrggbbaa = false, -- #RRGGBBAA (8-digit)
				hash_aarrggbb = false, -- #AARRGGBB (QML-style, alpha first)
				aarrggbb = true, -- 0xAARRGGBB
				no_hash = false, -- hex without '#' at word boundaries
			},
		},
		display = {
			mode = "virtualtext", -- string or list: "background"|"foreground"|"underline"|"virtualtext"
			virtualtext = {
				char = "⏺", -- character used for virtualtext
				position = "eol", -- "eol"|"before"|"after"
				hl_mode = "foreground", -- "background"|"foreground"
			},
			priority = {
				default = 150, -- extmark priority for normal highlights
				lsp = 200, -- extmark priority for LSP/Tailwind highlights
			},
			disable_document_color = true, -- true (all LSPs) | false | { lsp_name = true, ... }
		},
	},
})

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
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescript = { "prettierd", "biome" },
		typescriptreact = { "prettierd", "biome" },
		astro = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd", "biome" },
		htmlangular = { "prettierd", "biome" },
		json = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		python = { "ruff_format", "ruff_fix", "isort" },
	},
	notify_on_error = false,
	format_on_save = function(bufnr)
		return {
			timeout_ms = 3000,
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

vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

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
					{ "kind_icon", "label", gap = 1 },
					{ "kind" },
					-- { "item_idx" },
					-- { "label", "label_description", gap = 2 },
					-- { "kind_icon" },
					-- { "kind" },
				},
				-- components = {
				-- 	label_description = {
				-- 		highlight = "PMenu",
				-- 	},
				-- 	item_idx = {
				-- 		text = function(ctx)
				-- 			return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
				-- 		end,
				-- 		highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
				-- 	},
				-- },
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
