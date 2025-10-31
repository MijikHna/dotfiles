return {
  "andweeb/presence.nvim",
  event = "VeryLazy",
  config = function()
    require("presence").setup({
      auto_update = true,
      neovim_image_text = "The One True Text Editor",
      main_image = "file",
      client_id = "793271441293967371",
      log_level = nil,
      debounce_timeout = 30,
      enable_line_number = false,
      blacklist = {
        ".env",
        "/media/" .. os.getenv("ME") .. "/WindowsD/vaults/KeyNotes",
        "/media/" .. os.getenv("ME") .. "/WindowsD/vaults/CheatSheets",
        "/media/" .. os.getenv("ME") .. "/WindowsD/vaults/CourseNotes",
        os.getenv("HOME") .. "/Desktop/WEEKLY VIM LEARNING",
        os.getenv("HOME") .. "/.dotfiles",
      },
      buttons = false,
      file_assets = {},
      show_time = true,
      editing_text = "Editing %s",
      file_explorer_text = "Browsing %s",
      git_commit_text = "Committing changes",
      plugin_manager_text = "Managing plugins",
      reading_text = "Reading %s",
      workspace_text = "Working on %s",
      line_number_text = "Line %s out of %s",
    })
  end,
}
