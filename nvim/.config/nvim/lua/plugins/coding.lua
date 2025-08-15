return {
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "[S]earch & [R]eplace (GrugFar)" },
		},
	},
	{
		"mistweaverco/kulala.nvim",
		keys = {
			{ "<leader>Rs", require("kulala").run, desc = "Send request" },
			{ "<leader>Rb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
	},
	{
		"benomahony/uv.nvim",
		opts = {
			picker_integration = true,
			auto_activate_venv = true,
			notify_activate_venv = true,
		},
	},
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {}, -- your configuration
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			{
				opts = {
					enable_close = true,
					enable_rename = true,
					enable_close_on_slash = false,
				},
			},
		},
	},
	-- For reading .env files
	{
		"tpope/vim-dotenv",
	},
	-- For code diagnostics
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},

	-- For code formatting
	{
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
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},

	-- For Autocompletion
	{
		"saghen/blink.cmp",
		version = "1.*",
		opts = {
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
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- For LSP/DAPs installing
	{
		"mason-org/mason.nvim",
		lazy = false,
		opts = {
			ensure_installed = { "http", "c" },
			ui = {
				border = "rounded",
			},
		},
	},

	-- For Syntax highlighting
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
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
				},
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				auto_install = true,

				-- List of parsers to ignore installing (for "all")
				ignore_install = { "some_parser" },

				highlight = {
					enable = true,
					disable = { "help" }, -- list of language that will be disabled
					additional_vim_regex_highlighting = false,
				},

				-- Other modules you might want (optional)
				indent = { enable = true },
				incremental_selection = { enable = true },
				textobjects = { enable = true },
			})
		end,
	},
}
