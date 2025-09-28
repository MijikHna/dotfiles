package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

return {
  {
    "OXY2DEV/markview.nvim",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = { file_type = { "markdown", "Avante", "copilot-chat", "codecompanion" } },
  },
  {
    "3rd/image.nvim",
    enabled = true,
    commit = "21909e3eb03bc738cce497f45602bf157b396672",
    event = "VeryLazy",
    config = function()
      require("image").setup({
        backend = "kitty",
        kitty_method = "normal",
        processor = "magick_cli", -- "magick_cli" or "magick_rock"
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = true,
            download_remote_images = false,
            only_render_image_at_cursor = true,
            only_render_image_at_cursor_mode = "inline",     -- "popup" or "inline"
            filetypes = { "markdown", "vimwiki", "quarto" }, -- markdown extensions (ie. quarto) can go here
            floating_windows = true,
          },
          html = { enabled = false },
          css = { enabled = false },
          neorg = { enabled = false },
          typst = { enabled = false },

        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 60,
        max_height_window_percentage = 60,
        window_overlap_clear_enabled = true,                                                -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
        editor_only_render_when_focused = true,                                             -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true,                                             -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
      })
    end,
    keys = {
      {
        "<leader>ici",
        function()
          require("image").clear()
        end,
        desc = "[C]lear [I]mage",
        silent = false,
      },
    },
  },
  {
    "3rd/diagram.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = { "3rd/image.nvim" },
    branch = "feature/toggle",
    opts = {
      renderer_options = {
        mermaid = {
          background = '"#888888 "',
          theme = "dark",
          scale = 1,
        },
      },
    },
    keys = {
      {
        "<leader>icd",
        function()
          vim.notify(require("diagram").get_cache_dir())
        end,
        desc = "Get [C]ache [D]ir",
        silent = false,
      },
    },
  },
}
