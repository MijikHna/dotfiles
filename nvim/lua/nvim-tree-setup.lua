require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  -- hijack_directories = {
  --   enable = true,
  --   auto_open = true,
  -- },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  view = {
    float = {
      enable = false,
      open_win_config = {
        width = 170,
        height = 30,
        row = 10,
        col = 75,
      },
    },
    -- hide_root_folder = false,
    side = 'right',
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    width = 40,
  },
  trash = {
    cmd = "trash",
    require_confirm = true
  }
}
