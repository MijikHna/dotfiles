return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local nvim_tree = require("nvim-tree")

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvim_tree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      open_on_tab = false,
      hijack_cursor = false,
      update_cwd = false,
      diagnostics = { enable = false, icons = { hint = "", info = "", warning = "", error = "" } },
      update_focused_file = { enable = false, update_cwd = false, ignore_list = {} },
      system_open = { cmd = nil, args = {} },
      filters = { dotfiles = false, custom = {} },
      git = { enable = true, ignore = false, timeout = 500 },
      view = {
        float = {
          enable = false,
          open_win_config = { width = 170, height = 30, row = 10, col = 75 },
        },
        side = "right",
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        width = 40,
      },
      trash = { cmd = "gio trash", require_confirm = true },
    })

    -- keymaps
    local keymap = vim.keymap

    keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "[E]xplorer [T]oggle" })
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "[E]xplore [R]efresh" })
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "[E]xplorer [F]inder Toggle" })
  end,
}
