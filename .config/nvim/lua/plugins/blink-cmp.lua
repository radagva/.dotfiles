return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
		keymap = { preset = "default" },

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = {
					border = "rounded",
				},
			},
			menu = {
				border = "rounded",
				draw = {
					columns = {
						{ "item_idx" },
						{ "label", "label_description", gap = 2 },
						{ "kind_icon" },
						{ "kind" },
					},
					components = {
						label_description = {
							highlight = "PMenu",
						},
						item_idx = {
							text = function(ctx)
								return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
							end,
							highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
						},
					},
				},
			},
		},

		sources = {
			default = { "lsp", "path" },
			per_filetype = {
				sql = { "dadbod" },
			},
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
