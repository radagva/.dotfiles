local gh = require("config.utils").gh

vim.pack.add({ gh("nvim-orgmode/orgmode") })

require("orgmode").setup({
	org_agenda_files = "~/Documents/notes/**/*",
	org_default_notes_file = "~/Documents/notes/refile.org",
})
