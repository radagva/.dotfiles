local github = require("config.utils").github

vim.pack.add({
	github("nvim-lua/plenary.nvim"),
	github("MunifTanjim/nui.nvim"),
	github("nvim-tree/nvim-web-devicons"),
	-- github("mistweaverco/kulala.nvim"),
	github("mason-org/mason.nvim"),
	github("nvim-treesitter/nvim-treesitter"),
	github("neovim/nvim-lspconfig"),
	github("saghen/blink.cmp", { "v1.10.1" }),
	github("stevearc/conform.nvim"),
	github("tpope/vim-dotenv"),
	github("tpope/vim-dadbod"),
	github("kristijanhusak/vim-dadbod-completion"),
	github("kristijanhusak/vim-dadbod-ui"),
	github("windwp/nvim-ts-autotag"),
	github("dmmulroy/tsc.nvim"),
	github("benomahony/uv.nvim"),
	github("catgoose/nvim-colorizer.lua"),
	github("mfussenegger/nvim-dap"),
	github("MagicDuck/grug-far.nvim"),
	github("nvim-flutter/flutter-tools.nvim"),
	github("nvim-telescope/telescope.nvim"),
	github("wasabeef/melos.nvim"),
	github("igorlfs/nvim-dap-view", { version = vim.version.range("1.*") }),
	github("mfussenegger/nvim-dap-python"),
	github("mxsdev/nvim-dap-vscode-js"),
	github("leoluz/nvim-dap-go"),
	-- github("tpope/vim-fugitive"),
	github("lewis6991/gitsigns.nvim"),
	github("nvim-mini/mini.nvim"),
	github("echasnovski/mini.icons"),
	github("echasnovski/mini.ai"),
	github("echasnovski/mini.pairs"),
	github("echasnovski/mini.surround"),
	github("folke/snacks.nvim"),
	github("folke/flash.nvim"),
	github("folke/persistence.nvim"),
	github("mrjones2014/smart-splits.nvim"),
	github("olimorris/persisted.nvim"),
	github("MeanderingProgrammer/render-markdown.nvim", { name = "render-markdown" }),
	github("obsidian-nvim/obsidian.nvim", { name = "obsidian" }),
	github("stevearc/oil.nvim"),
	-- github("antoinemadec/FixCursorHold.nvim"),
	github("nvim-neotest/neotest"),
	github("nvim-neotest/nvim-nio"),
	github("nvim-neotest/neotest-python"),
	github("nvim-neotest/neotest-jest"),
	github("marilari88/neotest-vitest"),
	github("radagva/neotest-dart", { version = "monorepo-support" }),
	github("folke/which-key.nvim"),
	github("nvzone/showkeys"),
})

require("core.lsp")
require("config.options")
require("config.keymaps")
require("config.autocmd")
require("ui.statusline")

require("ui.winbar").setup()
require("ui.pack")
