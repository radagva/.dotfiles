vim.pack.add({ "https://github.com/folke/snacks.nvim" })

local snacks = require("snacks")

snacks.setup({
	scope = {},
	input = { enabled = false },
	rename = { enabled = false },
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
		-- layout = { preset = "ivy", layout = { position = "bottom" } }
	})
end

local function searchfordotfiles()
	snacks.picker.files({
		cwd = "~/.dotfiles",
		hidden = true,
		-- layout = { preset = "ivy", layout = { position = "bottom" } },
	})
end

local function searchforfiles()
	snacks.picker.grep({
		hidden = true,
		-- layout = { preset = "ivy", layout = { position = "bottom" } }
	})
end

local function searchforsymbols()
	snacks.picker.lsp_symbols()
end

local function searchfordiagnostics()
	snacks.picker.diagnostics()
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
