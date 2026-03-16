return {
	"folke/snacks.nvim",
	dependencies = {
		"folke/which-key.nvim",
	},
	priority = 1000,
	lazy = false,
	opts = {
		gh = {},
		-- dashboard = {},
		lazygit = {
			configure = true,
		},
		bigfile = { enabled = true },
		picker = {
			enabled = true,
			matcher = {
				frecency = true,
			},
			sources = {
				explorer = {
					layout = {
						preview = "main",
						-- Optional: customize layout for better visuals
						preset = "sidebar",
						position = "right",
					},
				},
			},
			-- layout = {
			-- 	preview = "right",
			-- 	layout = {
			-- 		box = "vertical",
			-- 		backdrop = false,
			-- 		width = 0,
			-- 		height = 0.4,
			-- 		position = "bottom",
			-- 		border = "top",
			-- 		title = " {title} {live} {flags}",
			-- 		title_pos = "left",
			-- 		{ win = "input", height = 1, border = "bottom" },
			-- 		{
			-- 			box = "horizontal",
			-- 			{ win = "list", border = "none" },
			-- 			{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
			-- 		},
			-- 	},
			-- },
			-- sources = {
			-- 	explorer = {
			-- 		cycle = true,
			-- 		auto_close = true,
			-- 		layout = {
			-- 			preset = "sidebar",
			-- 			-- preview = "main",
			-- 			layout = {
			-- 				width = 0.2,
			-- 				min_width = 120,
			-- 				position = "left",
			-- 				-- preview = "main",
			-- 			},
			-- 			-- box = "horizontal",
			-- 			-- width = 0.8,
			-- 			-- min_width = 120,
			-- 			-- height = 0.8,
			-- 			-- {
			-- 			-- 	box = "vertical",
			-- 			-- 	border = true,
			-- 			-- 	title = "{title} {live} {flags}",
			-- 			-- 	{ win = "input", height = 1, border = "bottom" },
			-- 			-- 	{ win = "list", border = "none" },
			-- 			-- },
			-- 			-- { win = "preview", title = "{preview}", border = true, width = 0.5 },
			-- 		},
			-- 		-- layout = { preview = "right" },
			-- 	},
			-- },
			--
			-- -- layout = { preset = "ivy_split", layout = { position = "bottom" } },
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
						hidden = true,
						layout = { preset = "vertical" },
						-- layout = { preset = "ivy", layout = { position = "bottom" } },
						win = {
							list = {
								keys = {
									["H"] = { "preview_scroll_left", mode = { "i", "n" } },
									["J"] = { "preview_scroll_down", mode = { "i", "n" } },
									["K"] = { "preview_scroll_up", mode = { "i", "n" } },
									["L"] = { "preview_scroll_right", mode = { "i", "n" } },
									-- ["<M-h>"] = { "toggle_hidden", mode = { "i", "n" } },
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
					Snacks.picker.buffers({
						-- layout = { preset = "ivy", layout = { position = "bottom" } }
					})
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
						-- layout = { preset = "ivy", layout = { position = "bottom" } },
					})
				end,
				desc = "Search .dot configs",
				silent = true,
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep({
						hidden = true,
						-- layout = { preset = "ivy", layout = { position = "bottom" } }
					})
				end,
				desc = "Search for text",
				silent = true,
			},
			{
				"<leader>sd",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "LSP Diagnostics",
				silent = true,
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
				silent = true,
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
			{
				"<leader>gp",
				function()
					Snacks.picker.gh_pr()
				end,
				desc = "GitHub Pull Requests (open)",
				silent = true,
			},
			{
				"<leader>gP",
				function()
					Snacks.picker.gh_pr({ state = "all" })
				end,
				desc = "GitHub Pull Requests (all)",
				silent = true,
			},
		})
	end,
}
