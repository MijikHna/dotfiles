return {
  "Civitasv/cmake-tools.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  enabled = true,
  config = function ()
    require("cmake-tools").setup({
      cmake_command = "cmake",
      ctest_command = "ctest",
      cmake_use_preset = true,
      cmake_regenerate_on_save = true,
      cmake_generate_options = {},
      cmake_build_options = {},
      cmake_build_directory = "build/${variant:buildType}",
      cmake_soft_link_compile_commands = true,
      cmake_compile_commands_from_lsp = true,
      cmake_kits_path = os.getenv("HOME") .. "/.local/share/CMakeTools/cmake-tools-kits.json",
      cmake_variants_message = { short = { show = true }, long = { show = true, max_length = 40 } },
      cmake_executor = {
        name = "toggleterm",
        opts = {},
        default_opts = {
          quickfix = {
            show = "always",
            position = "belowright",
            size = 40,
            encoding = "utf-8",
            auto_close_when_success = true,
          },
          toggleterm = {
            direction = "horizontal",
            close_on_exit = false,
            auto_scroll = true,
            singleton = true,
          },
        },
      },
      cmake_runner = {
        name = "toggleterm",
        opts = {},
        default_opts = {
          quickfix = {
            show = "always",
            position = "belowright",
            size = 30,
            encoding = "utf-8",
            auto_close_when_success = true,
          },
          toggleterm = {
            direction = "horizontal",
            close_on_exit = false,
            auto_scroll = true,
            singleton = true,
            auto_close_when_success = true,
          },
        },
      },
      cmake_notifications = {
        runner = { enabled = false },
        executor = { enabled = true },
        spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
        refresh_rate_ms = 500,
      },
      cmake_virtual_text_support = true,
    })
  end,
}
