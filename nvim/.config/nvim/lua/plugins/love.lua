-- using lazy.nvim
return {
	"S1M0N38/love2d.nvim",
	event = "VeryLazy",
	version = "2.*",
	opts = {
		path_to_love_bin = "/Applications/love.app/Contents/MacOS/love",
	},
	keys = {
		{ "<leader>v", ft = "lua", desc = "LÖVE" },
		{ "<leader>vv", "<cmd>LoveRun<cr>", ft = "lua", desc = "Run LÖVE" },
		{ "<leader>vs", "<cmd>LoveStop<cr>", ft = "lua", desc = "Stop LÖVE" },
	},
}
