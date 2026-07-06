local github = require("config.utils").github

vim.pack.add({ { src = github("datsfilipe/vesper.nvim") } })

require("vesper").setup({})
