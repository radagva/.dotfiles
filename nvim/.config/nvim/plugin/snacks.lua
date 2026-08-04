local gh = require("config.utils").github

vim.pack.add({ gh("folke/snacks.nvim"), gh("folke/persistence.nvim") })

local snacks = require("snacks")

snacks.setup({
	scope = {},
	input = { enabled = false },
	rename = { enabled = false },
	bigfile = { enabled = true },
	-- dashboard = {
	-- 	preset = {
	-- 		header = [[
	--    ]],
	-- 	},
	-- },
	picker = {
		enabled = true,
		matcher = {
			frecency = true,
		},
		actions = {
			open_in_float = function(picker, item)
				-- Close the picker window first
				picker:close()

				if not item or not item.file then
					return
				end

				-- Get current screen dimensions to center the floating window
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)

				-- Create a new scratch buffer for the file
				local buf = vim.api.nvim_create_buf(false, true)
				--
				-- Configure the floating window layout
				local win = vim.api.nvim_open_win(buf, true, {
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					style = "minimal",
					border = "rounded",
				})

				-- Edit the targeted file inside this new floating window
				vim.cmd("edit " .. vim.fn.fnameescape(item.file))
			end,
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
		win = {
			input = {
				keys = {
					["<C-f>"] = { "open_in_float", mode = { "n", "i" } },
				},
			},
		},
	},
	explorer = {
		enabled = true,
	},
})

local function searchfiles()
	local keys = {
		["H"] = { "preview_scroll_left", mode = { "i", "n" } },
		["<C-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
		["<C-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
		["L"] = { "preview_scroll_right", mode = { "i", "n" } },
		["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
		["<c-i>"] = { "toggle_ignored", mode = { "i", "n" } },
	}

	snacks.picker.files({
		-- hidden = true,
		-- layout = { preset = "vscode", hidden = {}, preview = "main" },
		layout = { preset = "ivy", layout = { position = "bottom" } },
		win = {
			list = { keys = keys },
			input = { keys = keys },
			preview = { keys = keys },
		},
		show_empty = true,
		supports_live = true,
	})
end

local function searchbuffers()
	snacks.picker.buffers({
		layout = { preset = "ivy", layout = { position = "bottom" } },
	})
end

local function searchfordotfiles()
	snacks.picker.files({
		cwd = "~/.dotfiles",
		hidden = true,
		layout = { preset = "ivy", layout = { position = "bottom" } },
	})
end

local function searchforfiles()
	snacks.picker.grep({
		hidden = true,
		layout = { preset = "ivy", layout = { position = "bottom" } },
	})
end

local function searchforsymbols()
	snacks.picker.lsp_symbols({ layout = { preset = "ivy", layout = { position = "bottom" } } })
end

local function searchfordiagnostics()
	snacks.picker.diagnostics({ layout = { preset = "ivy", layout = { position = "bottom" } } })
end

local function openexplorer()
	snacks.explorer.open()
end

vim.keymap.set("n", "<leader><leader>", searchfiles, { silent = true, desc = "Search for files" })
vim.keymap.set("n", "<leader>s", "", { silent = true, desc = "Search" })
vim.keymap.set("n", "<leader>sb", searchbuffers, { silent = true, desc = "Search for buffers" })
vim.keymap.set("n", "<leader>sc", searchfordotfiles, { silent = true, desc = "Search for dotfiles" })
vim.keymap.set("n", "<leader>sg", searchforfiles, { silent = true, desc = "Search for text" })
vim.keymap.set("n", "<leader>ss", searchforsymbols, { silent = true, desc = "Search for symbols" })
vim.keymap.set("n", "<leader>sd", searchfordiagnostics, { silent = true, desc = "Search for diagnostics" })
vim.keymap.set("n", "<leader>e", openexplorer, { silent = true, desc = "Open file explorer" })
