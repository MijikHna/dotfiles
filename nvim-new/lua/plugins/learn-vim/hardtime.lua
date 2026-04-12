vim.pack.add(
  { "https://github.com/m4xshen/hardtime.nvim" },
  {
    max_time = 1000,
    max_count = 10,
    disable_mouse = false,
    hint = true,
    notification = true,
    allow_different_key = false,
    disabled_keys = {
      ["<Up>"] = { "n" },
      ["<Down>"] = { "n" },
      ["<Left>"] = { "n" },
      ["<Right>"] = { "n" },
    },
    hint_keys = { "k", "j", "^", "$", "a", "i", "d", "y", "c", "l" },
    disabled_filetypes = {
      "qf",
      "netrw",
      "NvimTree",
      "lazy",
      "mason",
      "terminal",
      "toggleterm",
      "dapui_console",
      "vim-plug",
      "undotree",
      "Trouble",
      "DiffviewFileHistory",
      "help",
      "trouble",
    },
  }
)
