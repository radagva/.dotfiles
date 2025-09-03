local lualine = require("extensions.lualine")

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({ --- @diagnostic disable-line
				background_colour = "#000000",
			})

			vim.notify = notify
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = {
					normal = { a = { bg = lualine.bg }, b = { bg = lualine.bg }, c = { bg = lualine.bg } },
					insert = { a = { bg = lualine.bg }, b = { bg = lualine.bg }, c = { bg = lualine.bg } },
					visual = { a = { bg = lualine.bg }, b = { bg = lualine.bg }, c = { bg = lualine.bg } },
					replace = { a = { bg = lualine.bg }, b = { bg = lualine.bg }, c = { bg = lualine.bg } },
					command = {
						a = { bg = lualine.bg, fg = "#ffa066" },
						b = { bg = lualine.bg },
						c = { bg = lualine.bg },
					},
					inactive = { a = { bg = lualine.bg }, b = { bg = lualine.bg }, c = { bg = lualine.bg } },
				},
				icons_enabled = true,
				disabled_component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				filetypes = { statusline = {}, winbar = {} },
				ignore_focus = {
					"dapui_watches",
					"dapui_breakpoints",
					"dapui_scopes",
					"dapui_console",
					"dapui_stacks",
					"dap-repl",
					"dbui",
					"dbout",
					"neo-tree",
				},
				tabline = {},
				winbar = {},
				inactive_winbar = {},
				extensions = {},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1, fmt = lualine.pretty_path } },
				lualine_x = { lualine.debugger },
				lualine_y = { "progress" },
				lualine_z = {
					"location",
					"filetype",
					-- { lualine.ip_address, color = { fg = "#ff9e64" } }
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({
				"*",
			}, { mode = "background" })
		end,
	},
	{
		"folke/twilight.nvim",
		opts = {},
		keys = {
			{
				"<leader>ute",
				":TwilightEnable<cr>",
				desc = "Enable twilight",
				silent = true,
			},
			{
				"<leader>utd",
				":TwilightDisable<cr>",
				desc = "Disable twilight",
				silent = true,
			},
		},
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = {
	-- 		presets = {
	-- 			-- bottom_search = true, -- use a classic bottom cmdline for search
	-- 			-- command_palette = true, -- position the cmdline and popupmenu together
	-- 			-- long_message_to_split = true, -- long messages will be sent to a split
	-- 			inc_rename = true, -- enables an input dialog for inc-rename.nvim
	-- 			lsp_doc_border = true, -- add a border to hover docs and signature help
	-- 		},
	-- 	},
	-- 	dependencies = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- },
	-- {
	-- 	"nvimdev/dashboard-nvim",
	-- 	event = "VimEnter",
	-- 	lazy = false,
	-- 	opts = {
	-- 		theme = "doom",
	-- 		config = {
	-- 			header = {
	-- 				[[                                                   ]],
	-- 				[[                                              ___  ]],
	-- 				[[                                           ,o88888 ]],
	-- 				[[                                        ,o8888888' ]],
	-- 				[[                  ,:o:o:oooo.        ,8O88Pd8888"  ]],
	-- 				[[              ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"    ]],
	-- 				[[            ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"      ]],
	-- 				[[           , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"        ]],
	-- 				[[          , ..:.::o:ooOoOO8O888O8O,COCOO"          ]],
	-- 				[[         , . ..:.::o:ooOoOOOO8OOOOCOCO"            ]],
	-- 				[[          . ..:.::o:ooOoOoOO8O8OCCCC"o             ]],
	-- 				[[             . ..:.::o:ooooOoCoCCC"o:o             ]],
	-- 				[[             . ..:.::o:o:,cooooCo"oo:o:            ]],
	-- 				[[          `   . . ..:.:cocoooo"'o:o:::'            ]],
	-- 				[[          .`   . ..::ccccoc"'o:o:o:::'             ]],
	-- 				[[         :.:.    ,c:cccc"':.:.:.:.:.'              ]],
	-- 				[[       ..:.:"'`::::c:"'..:.:.:.:.:.'               ]],
	-- 				[[     ...:.'.:.::::"'    . . . . .'                 ]],
	-- 				[[    .. . ....:."' `   .  . . ''                    ]],
	-- 				[[  . . . ...."'                                     ]],
	-- 				[[  .. . ."'                                         ]],
	-- 				[[ .                                                 ]],
	-- 				[[                                                   ]],
	-- 				[[                      Angel Rada                   ]],
	-- 				[[                                                   ]],
	-- 				[[                                                   ]],
	-- 			},
	-- 			center = {
	-- 				{
	-- 					icon = " ",
	-- 					desc = "[L]azy plugin manager",
	-- 					group = "@property",
	-- 					action = "Lazy",
	-- 					key = "l",
	-- 					desc_hl = "String",
	-- 					key_hl = "Number",
	-- 					icon_hl = "group",
	-- 				},
	-- 				{
	-- 					icon = " ",
	-- 					desc = "[M]ason",
	-- 					group = "@property",
	-- 					action = "Mason",
	-- 					key = "m",
	-- 					desc_hl = "String",
	-- 					key_hl = "Number",
	-- 					icon_hl = "group",
	-- 				},
	-- 				{
	-- 					icon = " ",
	-- 					desc = "[C]heckhealth",
	-- 					group = "@property",
	-- 					action = "checkhealt",
	-- 					key = "c",
	-- 					desc_hl = "String",
	-- 					key_hl = "Number",
	-- 					icon_hl = "group",
	-- 				},
	-- 				{
	-- 					icon = "󰊳 ",
	-- 					desc = "[O]pen last session                  ",
	-- 					key = "o",
	-- 					action = 'lua require("persistence").load()',
	-- 					desc_hl = "String",
	-- 					key_hl = "Number",
	-- 					icon_hl = "group",
	-- 				},
	-- 				{
	-- 					icon = "󰿅 ",
	-- 					desc = "[Q]uit",
	-- 					key = "q",
	-- 					action = "qa!",
	-- 					desc_hl = "String",
	-- 					key_hl = "Number",
	-- 					icon_hl = "group",
	-- 				},
	-- 			},
	-- 			footer = {},
	-- 			vertical_center = true,
	-- 			plugins = true,
	-- 		},
	-- 	},
	-- 	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	-- },
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			animate = {
				enabled = false,
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		lazy = false,
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
		},
	},
	{ "RRethy/vim-illuminate" },
}
