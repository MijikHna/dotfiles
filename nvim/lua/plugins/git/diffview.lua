return {
  "sindrets/diffview.nvim",
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_horizontal" },
    },
  },
  config = true,
  init = function()
    local keymap = vim.keymap

    keymap.set("n", "<leader>gh", ":DiffviewOpen<CR>", { noremap = true, silent = true })
    keymap.set("n", "<leader>gc", ":DiffviewClose<CR>", { noremap = true, silent = true })
    keymap.set("n", "<leader>dvt", ":DiffviewToggleFiles<CR>", { noremap = true, silent = true })
    keymap.set("n", "<leader>dvf", ":DiffviewFocusFiles<CR>", { noremap = true, silent = true })
  end
}
