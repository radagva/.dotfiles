return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    win_options = {
      winbar = "%{v:lua.require('oil').get_current_dir()}",
    },
    keymaps = {
      ["<C-v>"] = {
        callback = function()
          require("oil").select({ vertical = true, close = true })
        end,
        desc = "select_vsplit",
        mode = "n",
      },
      ["<C-s>"] = {
        callback = function()
          require("oil").select({ horizontal = true, close = true })
        end,
        desc = "select_vsplit",
        mode = "n",
      },
    },
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    { "-", ":Oil<cr>", desc = "Oil" },
  }
}
