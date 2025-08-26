return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			win_options = {
				winbar = "%{v:lua.require('oil').get_current_dir()}",
			},
			keymaps = {
				["<C-v>"] = {
					callback = function()
						require("oil").select({ vertical = true, close = true })
					end,
					desc = "select_vsplit",
					mode = "n",
				},
				["<C-s>"] = {
					callback = function()
						require("oil").select({ horizontal = true, close = true })
					end,
					desc = "select_vsplit",
					mode = "n",
				},
			},
		},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = {
			{ "-", ":Oil<cr>", desc = "Oil" },
		},
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = function()
			local actions = require("fzf-lua").actions
			local extensions = require("extensions.fzf-lua")

			actions = {
				files = {
					["enter"] = actions.file_edit_or_qf,
					["ctrl-s"] = actions.file_split,
					["ctrl-v"] = actions.file_vsplit,
					["ctrl-i"] = actions.toggle_ignore,
					["ctrl-h"] = actions.toggle_hidden,
					["ctrl-x"] = extensions.create_file_action,
				},
				dir = {
					["ctrl-x"] = extensions.create_file_action,
				},
			}

			return {
				actions = actions,
				grep = {
					rg_glob = true,
				},
				files = {
					cwd_prompt = false,
					prompt = "Files ❯ ",
					formatter = "path.filename_first",
				},
				winopts = {
					preview = {
						layout = "vertical",
					},
				},
			}
		end,
		keys = {
			{
				"<leader><leader>",
				function()
					require("fzf-lua").files({ cmd = "fd --type f --exclude .git -i" })
				end,
				desc = "Fuzzy Find Files",
			},
			{
				"<leader>ss",
				function()
					require("fzf-lua").lsp_document_symbols()
				end,
				desc = "[S]earch document [S]ymbols",
			},

			{
				"<leader>sg",
				function()
					require("fzf-lua").live_grep()
				end,
				desc = "[G]lobal [Search] of text in files",
			},
			{
				"<leader>sb",
				function()
					require("fzf-lua").buffers()
				end,
				desc = "[B]uffers [Search]",
			},
			{
				"<leader>sc",
				function()
					require("fzf-lua").files({ cwd = "~/.dotfiles", cmd = "fd --type f --hidden --exclude .git" })
				end,
				desc = "[C]onfig [S]earch",
			},
		},
	},
}
