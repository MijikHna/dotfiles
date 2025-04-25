return {
  "rmagatti/auto-session",
  enabled = true,
  config = function()
    local auto_session = require("auto-session")

    auto_session.setup({
      log_level = "error",
      auto_save_enabled = true,
      auto_restore_enabled = true,
      silent_restore = true,
      auto_session_allowed_dirs = {
        "~/.dotfiles",
        "/media/" .. os.getenv("ME") .. "/WindowsD/vaults/*",
      },
      cwd_change_handling = true,
    })

    -- vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    --   callback = function()
    --     local status, err = pcall(function()
    --       local cwd = vim.fn.getcwd()
    --       local allowed_dirs = vim.g.auto_session_allowed_dirs
    --
    --       local is_allowed = false
    --       for _, dir in ipairs(allowed_dirs) do
    --         if cwd:match(vim.fn.glob(dir)) then
    --           is_allowed = true
    --           break
    --         end
    --       end
    --
    --       if not is_allowed then
    --         local choice = vim.fn.confirm("Save Session?", "&Yes\n&No", 2)
    --         if choice == 1 then
    --           vim.cmd("SessionSave")
    --         end
    --       end
    --     end)
    --
    --     if not status then
    --       local log_file = vim.fn.stdpath("state") .. "/auto-session-error.log"
    --       local log = io.open(log_file, "a")
    --       if log then
    --         log:write("Error on VimLeavePre: " .. err .. "\n")
    --         log:close()
    --       end
    --     end
    --   end,
    -- })
  end,
}
