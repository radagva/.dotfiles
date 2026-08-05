local gh = require("config.utils").gh
local highlights = require("config.utils").highlights

-- Local development checkout wins over the published plugin, so edits under
-- ~/Developer show up on the next :colorscheme dark-2026.
local dev = vim.fn.expand("~/Developer/Projects/personal/nvim-packages/dark-2026")

if vim.uv.fs_stat(dev) then
	vim.opt.runtimepath:prepend(dev)
else
	vim.pack.add({ gh("dark-2026-theme/nvim", { name = "dark-2026" }) })
end

require("dark-2026").setup({
	transparent = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
		floats = "transparent",
	},
	on_highlights = function(hl, colors)
		-- The shared util blanks these groups' fg along with their bg; put the
		-- theme's own foregrounds back.
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
