return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	---@module "neo-tree"
	---@type neotree.Config?
	opts = {
		close_if_last_window = true,
		sources = { "filesystem", "buffers", "git_status" },
		source_selector = {
			truncation_character = "...",
			winbar = true,
		},
		event_handlers = {
			{
				event = "vim_buffer_enter",
				handler = function()
					if vim.bo.filetype == "neo-tree" then
						vim.opt_local.number = false
						vim.opt_local.relativenumber = false
						vim.opt_local.statuscolumn = ""

						-- vim.cmd("setlocal nonumber")
					end
				end,
			},
		},
	},
	keys = {
		{ "<leader>e", ":Neotree toggle<cr>", desc = "Neotree" },
	},
}
