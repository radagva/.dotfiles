return {
	{ "RRethy/vim-illuminate" },
	{ "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
		init = function()
			require("which-key").add({
				{ "<leader>c", group = "Coding" },
				{ "<leader>l", group = "Lazy" },
				{ "<leader>ll", ":Lazy<cr>", desc = "Open Lazy" },
				{ "<leader>s", group = "Search" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>d", group = "Debugging" },
				{ "<leader>t", group = "Testing" },
				{ "<leader>o", group = "Obsidian" },
				{ "<leader>g", group = "Git" },
				{ "<leader>u", group = "UI" },
				{ "<leader>x", group = "Diagnostics" },
				{ "<leader>R", group = "Kulala/HTTP" },
				{ "<leader><Tab>", group = "Tabs" },
			})
		end,
	},

	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")

			notify.setup({
				background_colour = "#000000",
			})

			vim.notify = notify
		end,
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
}
