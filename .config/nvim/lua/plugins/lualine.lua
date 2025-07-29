local dap = {
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

local uip = function()
	local handle = io.popen("ipconfig getifaddr en0")
	if handle ~= nil then
		local output = handle:read("*a") -- Read all output
		handle:close()

		return output:gsub("%s+$", "")
	end

	return "localhost"
end

local bg = "#181616"

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			theme = {
				normal = {
					a = { bg = bg },
					b = { bg = bg },
					c = { bg = bg },
				},
				insert = { a = { bg = bg } },
				visual = { a = { bg = bg } },
				replace = { a = { bg = bg } },
				command = { a = { bg = bg, fg = "#ffa066" } },
				inactive = {
					a = { bg = bg },
					b = { bg = bg },
					c = { bg = bg },
				},
			},
			icons_enabled = true,
			-- component_separators = { left = "", right = "" },
			-- section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
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
			lualine_c = {},
			lualine_x = {
				dap,
				-- "encoding",
				-- "fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location", { uip, color = { fg = "#ff9e64" } } },
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
		function ShowLualineConfigFancy()
			local config = vim.inspect(require("lualine").get_config())

			-- Create a scratch buffer
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(config, "\n"))
			vim.api.nvim_buf_set_option(buf, "filetype", "lua")
			vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
			vim.api.nvim_buf_set_option(buf, "modifiable", false)
			vim.api.nvim_buf_set_name(buf, "✧ Lualine Configuration ✧")

			-- Create floating window
			local width = math.min(100, vim.o.columns - 10)
			local height = math.min(30, vim.o.lines - 10)
			local win = vim.api.nvim_open_win(buf, true, {
				relative = "editor",
				width = width,
				height = height,
				col = (vim.o.columns - width) / 2,
				row = (vim.o.lines - height) / 2 - 2,
				style = "minimal",
				border = "double",
				title = " Lualine Config ",
				title_pos = "center",
			})

			-- Add keymaps to close window
			vim.keymap.set("n", "q", function()
				vim.api.nvim_win_close(win, true)
			end, { buffer = buf })
			vim.keymap.set("n", "<Esc>", function()
				vim.api.nvim_win_close(win, true)
			end, { buffer = buf })
		end

		-- Map to <leader>lc
		vim.keymap.set("n", "<leader>lc", ShowLualineConfigFancy, { desc = "Show Lualine Config" })
	end,
}
