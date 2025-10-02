return {
	{
		dir = "~/Developer/Projects/personal/neovim-plugins/angular.nvim",
		dependencies = { "folke/which-key.nvim" },
		dev = true,
		-- "radagva/angular.nvim",
		opts = {
			auto_commands = true,
			schematics = {
				components = {
					skipTests = true,
					styles = "css",
				},
			},
		},
	},
	{
		"zerochae/endpoint.nvim",
		dependencies = {
			-- Choose one or more pickers (all optional):
			"nvim-telescope/telescope.nvim", -- For telescope picker
			"folke/snacks.nvim", -- For snacks picker
			"stevearc/dressing.nvim", -- Enhances vim.ui.select with telescope backend
			-- vim.ui.select picker works without dependencies
		},
		cmd = { "Endpoint", "EndpointRefresh" },
		opts = {
			ui = {
				show_icons = false,
			},
		},
		-- config = function()
		-- 	require("endpoint").setup()
		-- end,
		keys = {
			{ "<leader>E", ":Endpoint<cr>", desc = "Show list of endpoint", silent = true, noremap = true },
		},
	},
	--[[
  -- To perform global search and replace actions
  --]]
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{ "<leader>sr", "<cmd>GrugFar<cr>", desc = "[S]earch & [R]eplace (GrugFar)" },
		},
	},
	--[[
  -- To running HTTP requests
  --]]
	---@type LazyPluginSpec
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
			lsp = {
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<C-r>", function()
						require("kulala").run()
					end, { silent = true, buffer = bufnr, noremap = true })
				end,
			},
		},
		-- init = function()
		-- end,
	},
	{
		"code-biscuits/nvim-biscuits",
	},
	{
		"smjonas/inc-rename.nvim",
		opts = {},
	},
	--[[
  -- To run UV commands in python projects
  --]]
	{
		"benomahony/uv.nvim",
		opts = {
			picker_integration = true,
			auto_activate_venv = true,
			notify_activate_venv = true,
			keymaps = false,
			-- keymaps = {
			-- 	prefix = "<leader>cu",
			-- },
		},
	},
	--[[
  -- To have better autocompletion of tailwindcss classnames
  --]]
	{
		"luckasRanarison/tailwind-tools.nvim",
		name = "tailwind-tools",
		build = ":UpdateRemotePlugins",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		---@type TailwindTools.SettingsOption
		opts = {},
	},
	--[[
  -- To autoclose and autopair HTML/JSX/HTMX tags
  --]]
	{
		"windwp/nvim-ts-autotag",
		---@type nvim-ts-autotag.PluginSetup
		opts = {
			{
				opts = {
					enable_rename = true,
					enable_close_on_slash = false,
				},
			},
		},
	},
	--[[
  -- To read .env files
  --]]
	{ "tpope/vim-dotenv" },
	--[[
  -- To have better diagnostics
  --]]
	{
		"folke/trouble.nvim",
		opts = {},
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
	--[[
  -- To format code per language
  --]]
	{
		"stevearc/conform.nvim",
		---@type conform.setupOpts
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
	--[[
  -- To have better autocompletion per filetype
  --]]
	{
		"saghen/blink.cmp",
		version = "1.*",
		---@type blink.cmp.Config
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
				default = { "lsp", "path", "copilot" },
				per_filetype = {
					sql = { "dadbod" },
				},
				providers = {
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	--[[
  -- To easily install LSP or DAP clients right in .local/shared/mason folder
  --]]
	{
		"mason-org/mason.nvim",
		lazy = false,
		---@type MasonSettings
		opts = {
			ensure_installed = { "http", "c", "css-lsp" },
			ui = {
				border = "rounded",
			},
		},
	},
	--[[
  -- To have syntax highlight per filetype
  --]]
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		---@type TSConfig
		opts = {
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
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
