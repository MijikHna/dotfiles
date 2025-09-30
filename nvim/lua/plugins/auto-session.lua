return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      log_level = "error",
      enabled = true,
      auto_save = true,
      auto_restore = true,
      auto_restore_last_session = true,
      allowed_dirs = {},
      git_use_branch_name = true,
      git_auto_restore_on_branch_change = true,
      show_auto_restore_notif = true,
      legacy_cmds = false,
    })
  end,
}
