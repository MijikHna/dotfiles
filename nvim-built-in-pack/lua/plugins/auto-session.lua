vim.pack.add({"https://github.com/rmagatti/auto-session"})

require("auto-session").setup({
  log_level = "error",
  enabled = true,
  auto_save = true,
  auto_restore = true,
  auto_restore_last_session = false,
  allowed_dirs = {
    "~/.dotfiles",
    "/media/" .. os.getenv("ME") .. "/WindowsD/vaults/*",
  },
  close_filetypes_on_save = { "checkhealth", "codecompanion", "NvimTree" },
  git_use_branch_name = true,
  git_auto_restore_on_branch_change = true,
  show_auto_restore_notif = true,
  legacy_cmds = false,
})
