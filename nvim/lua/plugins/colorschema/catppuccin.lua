return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = true,
  priority = 1000,
  enabled = false,
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "transparent",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = { "italic" },
      functions = { "italic" },
      keywords = { "bold" },
      strings = {},
      variables = {},
      numbers = { "italic" },
      booleans = { "italic" },
      properties = {},
      types = {},
      operators = {},
    },
    color_overrides = {},
    custom_highlights = function(colors)
      return {
        Comment = { fg = "#89AEB1" },
        LineNr = { fg = colors.overlay0 },
      }
    end,
    integrations = {
      cmp = true,
      gitsigns = false,
      nvimtree = true,
      treesitter = true,
      notify = false,
      mini = false,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
    highlight_overrides = {
      all = function(colors)
        return {
          NvimTreeNormal = { bg = colors.none },
          CmpBorder = { fg = "#3e4145" },
        }
      end,
    },
  },
  init = function()
    vim.cmd("colorscheme catppuccin-mocha")
  end,
}
