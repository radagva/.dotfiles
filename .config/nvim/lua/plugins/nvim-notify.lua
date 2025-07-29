return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require("notify")
    notify.setup({ --- @diagnostic disable-line
      background_colour = "#000000"
    })

    vim.notify = notify
  end
}
