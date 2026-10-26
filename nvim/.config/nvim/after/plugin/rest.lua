local github = require("config.utils").github

-- local dev: rest.nvim (live edits; falls back to vim.pack once published)
local rest_dev = vim.fn.expand("~/Developer/personal/nvim-plugins/rest.nvim")
if vim.uv.fs_stat(rest_dev) then
	vim.opt.runtimepath:prepend(rest_dev)
else
	vim.pack.add({ github("radagva/rest.nvim") })
end
