local github = require("config.utils").github
local highlights = require("config.utils").highlights

local dev = vim.fn.expand("~/Developer/personal/themes/mocha/nvim")

if vim.uv.fs_stat(dev) then
	vim.opt.runtimepath:prepend(dev)
else
	vim.pack.add({ github("mochalate-theme/nvim", { name = "mochalate" }) })
end

require("mochalate").setup({
	transparent = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		floats = "transparent",
	},
	on_highlights = function(hl, colors)
		highlights(hl, colors, {
			NormalFloat = { fg = colors.fg },
			FloatBorder = { fg = colors.border_alt },
			FloatTitle = { fg = colors.fg_alt, bold = true },
			Pmenu = { fg = colors.fg },
			PmenuThumb = { bg = colors.fg_muted },
			StatusLine = { fg = colors.fg_dim },
			BlinkCmpMenuBorder = { fg = colors.border_alt },
			LspInlayHint = { fg = colors.fg_muted, bg = "none" },
		})
	end,
})
