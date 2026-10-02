local github = require("config.utils").github

vim.pack.add({
	github("nvim-lua/plenary.nvim"), -- dependency: for testing packages, required by melos
	github("nvim-telescope/telescope.nvim"), -- dependency: required by melos

	github("catgoose/nvim-colorizer.lua"), -- ui: for displaying colors codes with color presentation
	github("stevearc/oil.nvim"), -- ui: directory navigation
	github("folke/which-key.nvim"), -- ui: show keymaps tree
	github("nvzone/showkeys"), -- ui: show keys pressed

	github("mason-org/mason.nvim"), -- coding: for managing LSPs
	github("neovim/nvim-lspconfig"), -- coding: for managing LSPs configs
	github("nvim-treesitter/nvim-treesitter"), -- coding: manage syntax highlight + semantic tokens
	github("saghen/blink.cmp", { "v1.10.1" }), -- coding: for auto completion + CMP
	github("stevearc/conform.nvim"), -- coding: for linting and formatting
	github("tpope/vim-dotenv"), -- coding: for parsing & loading ENV variables
	github("tpope/vim-dadbod"), -- coding/ui: for running SQL queries
	github("kristijanhusak/vim-dadbod-completion"), -- coding: for SQL autocompletion
	github("kristijanhusak/vim-dadbod-ui"), -- coding/ui: for showing a DB UI
	github("windwp/nvim-ts-autotag"), -- coding: for autoclosing/renaming html/xml tags
	github("dmmulroy/tsc.nvim"), -- coding: for typecheking typescript projects
	github("benomahony/uv.nvim"), -- coding: for loading and managing UV python projects

	github("mfussenegger/nvim-dap"), -- debug: for setting up debugging sessions
	github("igorlfs/nvim-dap-view", { -- debug: for displaying a debug UI
		version = vim.version.range("1.*"),
	}),
	github("mfussenegger/nvim-dap-python"), -- debug: for setting up python DAP
	github("nvim-flutter/flutter-tools.nvim"), -- language: enable flutter code/project actions
	github("wasabeef/melos.nvim"), -- language: enable flutter package manager actions
	github("lewis6991/gitsigns.nvim"), -- git: enable git signs in the gutter bar and git diagnostics

	github("mrjones2014/smart-splits.nvim"), -- utils: for easy integration with terminal/tmux splits + nvim splits
	github("nvim-mini/mini.nvim"), -- utils: for enabling many mini utils
	github("echasnovski/mini.icons"), -- utils: for using mini icons instead of web dev icons
	github("echasnovski/mini.ai"), -- utils: for extenging Inside/Around text object actions
	github("echasnovski/mini.pairs"), -- utils: for auto creating closing pair (")]}'`)
	github("echasnovski/mini.surround"), -- utils: for managing surrounding characters
	github("MagicDuck/grug-far.nvim"), -- utils: for performiing global search & replace
	github("folke/snacks.nvim"), -- utils: swiss knife of plugins
	github("folke/flash.nvim"), -- utils: for highlighted text search
	github("olimorris/persisted.nvim"), -- utils: for persisting last session scoped by directory
})

require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("ui.statusline")
require("ui.winbar").setup()
require("ui.pack")
