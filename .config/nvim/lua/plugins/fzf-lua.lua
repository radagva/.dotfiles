local function create_file_action(selected)
	local path = selected[1]

	local parts = {}

	for part in path:gmatch("%S+") do
		table.insert(parts, part)
	end

	local parent_dir = parts[#parts]

	vim.ui.input({
		prompt = "New file: ",
		default = parent_dir .. "/",
		completion = "file",
	}, function(input)
		if not input or input == "" then
			return
		end

		local filename = input:gsub("[^%w %- _/%.%~]", ""):gsub("^%s+", ""):gsub("%s+$", "")

		local final_dir = vim.fn.fnamemodify(filename, ":h")
		if final_dir ~= "." and vim.fn.isdirectory(final_dir) == 0 then
			vim.fn.mkdir(final_dir, "p")
		end

		if vim.fn.filereadable(filename) == 0 then
			vim.fn.writefile({}, filename)
		end

		vim.cmd("edit " .. vim.fn.fnameescape(filename))
	end)
end

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = function()
		local actions = require("fzf-lua").actions
		actions = {
			files = {
				["enter"] = actions.file_edit_or_qf,
				["ctrl-s"] = actions.file_split,
				["ctrl-v"] = actions.file_vsplit,
				["ctrl-i"] = actions.toggle_ignore,
				["ctrl-h"] = actions.toggle_hidden,
				["ctrl-x"] = create_file_action,
			},
			dir = {
				["ctrl-x"] = create_file_action,
			},
		}

		return {
			actions = actions,
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
}
