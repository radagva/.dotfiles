return {
	filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
	on_attach = function(client, bufnr)
		if vim.bo[bufnr].filetype ~= "htmlangular" then
			return
		end
		local root_dir = client.config.root_dir
		if not root_dir then
			return
		end

		local ts_files = vim.fs.find(function(name)
			return name:match("%.component%.ts$") or name:match("%.ts$")
		end, {
			path = root_dir,
			type = "file",
			depth = 4,
			limit = 1,
		})
		if #ts_files == 0 then
			ts_files = vim.fs.find("*.ts", {
				path = root_dir,
				type = "file",
				depth = 2,
				limit = 1,
			})
		end
		if #ts_files > 0 then
			local ts_buf = vim.fn.bufadd(ts_files[1])
			vim.fn.bufload(ts_buf)
		end
	end,
}
