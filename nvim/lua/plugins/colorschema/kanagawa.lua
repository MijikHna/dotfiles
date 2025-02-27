return {
  "rebelot/kanagawa.nvim",
  priority = 1050,
  lazy = true,
  enabled = true,
  opts = {
    compile = false, -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = { -- add/modify theme and palette colors
      palette = {},
      theme = {
        all = {
          ui = {
            bg_gutter = "none",
          },
        },
      },
    },
    globalStatus = true,
    overrides = function(colors)
      return {
        -- LineNr = { bg = 'NONE' },
        -- SignColumn = { bg = 'NONE' },
        NvimTreeExecFile = { bold = false },
        NvimTreeImageFile = { bold = false },
        NvimTreeSpecialFile = { bold = false },
        Directory = { bold = true },
        WinSeparator = { fg = "#808080" },
      }
    end,
    theme = "wave", -- Load "wave" theme when 'background' option is not set
    background = { -- map the value of 'background' option to a theme
      dark = "wave", -- try "dragon" !
      light = "lotus",
    },
  },
  init = function()
    vim.cmd("colorscheme kanagawa")
  end,
}
