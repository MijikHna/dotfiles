vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })

local notify = require("notify")

notify.setup({
  stages = "fade_in_slide_out", -- Animation style (see below for details)
  on_open = nil,                -- Function called when a new window is opened, use for changing win settings/config
  on_close = nil,               -- Function called when a window is closed
  render = "default",           -- Render function for notifications. See notify-render()
  timeout = 5000,               -- Default timeout for notifications
  -- background_colour = "Normal", -- For stages that change opacity this is treated as the highlight behind the window, set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
  background_colour = "#1a1b26",
  minimum_width = 50, -- Minimum width for notification windows
  icons = {           -- Icons for the different levels
    ERROR = "",
    WARN = "",
    INFO = "",
    DEBUG = "",
    TRACE = "✎",
  },
  top_down = false,
})

vim.notify = require("notify")
vim.print = require("notify")

vim.keymap.set("n", "<leader>nc", notify.dismiss, { desc = "[N]otify [C]lose Popups" })
