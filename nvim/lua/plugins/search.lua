return {
  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    keys = {
      {
        "<leader>sr",
        "<cmd>lua require('spectre').open()<CR>",
        noremap = true,
        desc = "Open Spectre",
      },
      {
        "<leader>sv",
        "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
        noremap = true,
        desc = "Open Spectre Visual",
      },
      {
        "<leader>sw",
        "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
        noremap = true,
        desc = "Open Spectre with Word under Cursor",
      },
    },
    config = true,
  },
  {
    "MagicDuck/grug-far.nvim",
    enabled = true,
    keys = {
      {

        "<leader>sr",
        "<cmd>lua require('grug-far').open()<CR>",
        noremap = true,
        desc = "Open Search and Replace",
      },
      {
        "<leader>sv",
        "<cmd>lua require('grug-far').with_visual_selection()<CR>",
        noremap = true,
        desc = "Open Search and Replace Word",
      },
      {
        "<leader>sw",
        "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>')}})<CR>",
        noremap = true,
        desc = "Open Search and Replace Word",
      },
    },
    opts = {},
  },
}
