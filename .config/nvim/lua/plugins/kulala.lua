return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>Rs", require('kulala').run,   desc = "Send request" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  ft = { "http", "rest" },
  opts = {
    -- global_keymaps = false,
    -- global_keymaps_prefix = "<leader>R",
    -- kulala_keymaps_prefix = "",
  },
}
