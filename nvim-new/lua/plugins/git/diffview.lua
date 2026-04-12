vim.pack.add(
  { "https://www.github.com/sindrets/diffview.nvim" },
  {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      default = {
        layout = "diff2_horizontal",
        disable_diagnostics = true
      },
      merge_tool = {
        layout = "diff4_mixed",
        disable_diagnostics = true
      },
    },
  }
)

local keymap = vim.keymap

keymap.set("n", "<leader>gh", ":DiffviewOpen<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>gc", ":DiffviewClose<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>dvt", ":DiffviewToggleFiles<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>dvf", ":DiffviewFocusFiles<CR>", { noremap = true, silent = true })
