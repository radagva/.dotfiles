local debugger = {
	function()
		local status = require("dap").status()
		return status ~= "" and status or nil
	end,
	cond = function()
		return require("dap").session() ~= nil
	end,
	color = { fg = "#ff9e64" },
	on_click = function()
		require("dap").continue()
	end,
}

local ip_address = function()
	local handle = io.popen("ipconfig getifaddr en0")
	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return output:gsub("%s+$", "")
	end

	return "localhost"
end

local pretty_path = function(path)
	local rel_path = vim.fn.fnamemodify(path, ":~:.")

	local parts = vim.split(rel_path, "/", { plain = true })

	if #parts > 3 then
		parts = { "…", parts[#parts - 1], parts[#parts] }
	end

	return table.concat(parts, "/")
end

local bg = "none"

return {
	{
		"declancm/cinnamon.nvim",
		version = "*",
		opts = {
			keymaps = {
				basic = true,
				extra = true,
			},
		},
	},
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
					normal = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
					insert = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
					visual = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
					replace = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
					command = { a = { bg = bg, fg = "#ffa066" }, b = { bg = bg }, c = { bg = bg } },
					inactive = { a = { bg = bg }, b = { bg = bg }, c = { bg = bg } },
				},
				icons_enabled = true,
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { statusline = {}, winbar = {} },
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
				lualine_c = { { "filename", path = 1, fmt = pretty_path } },
				lualine_x = { debugger },
				lualine_y = { "progress" },
				lualine_z = { "location", "filetype", { ip_address, color = { fg = "#ff9e64" } } },
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
		init = function()
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
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
	-- Lua
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
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		lazy = false,
		opts = {
			theme = "doom",
			config = {
				header = {
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⢀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡖⠁⠀⠀⠀⠀⠀⠀⠈⢲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⠀⣼⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣧⠀⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⣸⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣿⣇⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⢀⣀⣤⣤⣤⣤⣀⡀⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣔⢿⡿⠟⠛⠛⠻⢿⡿⣢⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠀⣀⣤⣶⣾⣿⣿⣿⣷⣤⣀⡀⢀⣀⣤⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀ ",
					"⠀⠀⢠⣾⣿⡿⠿⠿⠿⣿⣿⣿⣿⡿⠏⠻⢿⣿⣿⣿⣿⠿⠿⠿⢿⣿⣷⡀⠀⠀ ",
					"⠀⢠⡿⠋⠁⠀⠀⢸⣿⡇⠉⠻⣿⠇⠀⠀⠸⣿⡿⠋⢰⣿⡇⠀⠀⠈⠙⢿⡄⠀ ",
					"⠀⡿⠁⠀⠀⠀⠀⠘⣿⣷⡀⠀⠰⣿⣶⣶⣿⡎⠀⢀⣾⣿⠇⠀⠀⠀⠀⠈⢿⠀ ",
					"⠀⡇⠀⠀⠀⠀⠀⠀⠹⣿⣷⣄⠀⣿⣿⣿⣿⠀⣠⣾⣿⠏⠀⠀⠀⠀⠀⠀⢸⠀ ",
					"⠀⠁⠀⠀⠀⠀⠀⠀⠀⠈⠻⢿⢇⣿⣿⣿⣿⡸⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠈⠀ ",
					"⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
					"⠀⠀⠀⠐⢤⣀⣀⢀⣀⣠⣴⣿⣿⠿⠋⠙⠿⣿⣿⣦⣄⣀⠀⠀⣀⡠⠂⠀⠀⠀ ",
					"⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠉⠀⠀⠀⠀⠀⠈⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀ ",
					"                               ",
					"          Angel Rada           ",
					"                               ",
				},
				center = {
					{
						icon = " ",
						desc = "[L]azy plugin manager",
						group = "@property",
						action = "Lazy",
						key = "l",
						desc_hl = "String",
						key_hl = "Number",
						icon_hl = "group",
					},
					{
						icon = " ",
						desc = "[M]ason",
						group = "@property",
						action = "Mason",
						key = "m",
						desc_hl = "String",
						key_hl = "Number",
						icon_hl = "group",
					},
					{
						icon = " ",
						desc = "[C]heckhealth",
						group = "@property",
						action = "checkhealt",
						key = "c",
						desc_hl = "String",
						key_hl = "Number",
						icon_hl = "group",
					},
					{
						icon = "󰊳 ",
						desc = "[O]pen last session                  ",
						key = "o",
						action = 'lua require("persistence").load()',
						desc_hl = "String",
						key_hl = "Number",
						icon_hl = "group",
					},
					-- {
					-- 	icon = " ",
					-- 	desc = "[P]rojecs",
					-- 	key = "p",
					-- 	action = "NeovimProjectDiscover",
					-- 	desc_hl = "String",
					-- 	key_hl = "Number",
					-- 	icon_hl = "group",
					-- },
					{
						icon = "󰿅 ",
						desc = "[Q]uit",
						key = "q",
						action = "qa!",
						desc_hl = "String",
						key_hl = "Number",
						icon_hl = "group",
					},
				},
				footer = {},
				vertical_center = true,
				plugins = true,
			},
		},
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
	{
		"folke/edgy.nvim",
		event = "VeryLazy",
		opts = {
			animate = {
				enabled = false,
			},
			bottom = {
				-- {
				-- 	title = "DB Query Result",
				-- 	ft = "dbout",
				-- 	width = 5.0,
				-- },
				-- {
				-- 	title = "Terminal",
				-- 	ft = "terminal",
				-- 	width = 5.0,
				-- },
				-- {
				-- 	title = "DapView",
				-- 	ft = "dap-view",
				-- 	width = 5.0,
				-- },
			},
			right = {
				-- {
				-- 	title = "Database",
				-- 	ft = "dbui",
				-- 	pinned = false,
				-- 	width = 0.3,
				-- 	open = function()
				-- 		vim.cmd("DBUI")
				-- 	end,
				-- },
			},
			left = {
				-- {
				-- 	title = "Fyler",
				-- 	ft = "fyler",
				-- 	size = { height = 0.5 },
				-- },
				-- {
				-- 	title = "Neo-Tree",
				-- 	ft = "neo-tree",
				-- 	filter = function(buf)
				-- 		return vim.b[buf].neo_tree_source == "filesystem"
				-- 	end,
				-- },
				-- {
				-- 	title = "Scopes",
				-- 	ft = "dapui_scopes",
				-- },
				-- {
				-- 	title = "Breakpoints",
				-- 	ft = "dapui_breakpoints",
				-- },
				-- {
				-- 	title = "Stacks",
				-- 	ft = "dapui_stacks",
				-- },
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
