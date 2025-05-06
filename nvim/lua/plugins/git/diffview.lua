return {
  "sindrets/diffview.nvim",
  keys = {
    {
      "<leader>gh",
      ":DiffviewOpen<CR>",
      { noremap = true, silent = true },
    },
    {
      "<leader>gc",
      ":DiffviewClose<CR>",
      { noremap = true, silent = true },
    },
  },
  opts = {
    enhanced_diff_hl = true,
    use_icons = true,
    view = {
      default = { layout = "diff2_horizontal" },
      merge_tool = { layout = "diff3_horizontal" },
    },
  },
  config = true,
}
