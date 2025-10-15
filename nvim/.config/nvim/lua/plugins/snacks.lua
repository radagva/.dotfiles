return {
	"folke/snacks.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = {
		lazygit = {
			configure = true,
		},
		bigfile = { enabled = true },
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
			},
			formatters = {
				text = {
					ft = nil, ---@type string? filetype for highlighting
				},
				file = {
					filename_first = true, -- display filename before the file path
					truncate = 40, -- truncate the file path to (roughly) this length
					filename_only = false, -- only show the filename
					icon_width = 2, -- width of the icon (in characters)
					git_status_hl = true, -- use the git status highlight group for the filename
				},
				selected = {
					show_always = false, -- only show the selected column when there are multiple selections
					unselected = true, -- use the unselected icon for unselected items
				},
				severity = {
					icons = true, -- show severity icons
					level = false, -- show severity level
					---@type "left"|"right"
					pos = "left", -- position of the diagnostics
				},
			},
		},
		explorer = {
			enabled = true,
		},
	},
	init = function()
		require("which-key").add({
			{
				"<leader><leader>",
				function()
					Snacks.picker.files({
						layout = { preset = "ivy", layout = { position = "bottom" } },
						win = {
							input = {
								keys = {
									["H"] = { "preview_scroll_left", mode = { "i", "n" } },
									["J"] = { "preview_scroll_down", mode = { "i", "n" } },
									["K"] = { "preview_scroll_up", mode = { "i", "n" } },
									["L"] = { "preview_scroll_right", mode = { "i", "n" } },
									["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
									["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
								},
							},
						},
						show_empty = true,
						supports_live = true,
					})
				end,
				silent = true,
			},
			{
				"<leader>sb",
				function()
					Snacks.picker.buffers({ layout = { preset = "ivy", layout = { position = "bottom" } } })
				end,
				desc = "Search for buffers",
				silent = true,
			},
			{
				"<leader>sc",
				function()
					Snacks.picker.files({
						cwd = "~/.dotfiles",
						hidden = true,
						layout = { preset = "ivy", layout = { position = "bottom" } },
					})
				end,
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep({ layout = { preset = "ivy", layout = { position = "bottom" } } })
				end,
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer.open()
				end,
				desc = "Show explorer",
				silent = true,
			},
			{
				"<leader>lg",
				function()
					Snacks.lazygit.open()
				end,
				desc = "Open lazygit",
			},
		})
	end,
}
