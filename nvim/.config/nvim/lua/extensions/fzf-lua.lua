local M = {}

M.create_file_action = function(selected)
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

return M
