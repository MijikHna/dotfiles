return {
  {
    "numToStr/FTerm.nvim",
    event = "VeryLazy",
    config = true,
    enabled = false,
    keys = {
      { "<Esc>", "<C-\\><C-n>", mode = "n", noremap = true, desc = "Exit terminal mode" },
      {
        "<leader>jjf",
        function()
          require("FTerm").toggle()
        end,
        mode = "n",
        desc = "Toggle terminal",
        silent = true,
      },
      {
        "<leader>jo",
        function()
          require("FTerm").open()
        end,
        mode = "n",
        noremap = true,
        desc = "Exit terminal mode",
      },
      {
        "<leader>jc",
        function()
          require("FTerm").close()
        end,
        mode = "n",
        noremap = true,
        desc = "Exit terminal mode",
      },
      {
        "<leader>je",
        function()
          require("FTerm").exit()
        end,
        mode = "n",
        noremap = true,
        desc = "Exit terminal mode",
      },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    enabled = true,
    opts = {},
    keys = {
      { "<Esc>", "<C-\\><C-n>", mode = "t", noremap = true, desc = "Exit terminal mode" },
      {
        "<leader>jjt",
        "<cmd>ToggleTerm direction=vertical size=80<CR>",
        mode = "n",
        desc = "Toggle terminal (vertical)",
        silent = true,
      },
      {
        "<leader>jjr",
        "<cmd>ToggleTerm size=20 direction=horizontal<CR>",
        mode = "n",
        desc = "Toggle terminal (horizontal)",
        silent = true,
      },
      {
        "<leader>jje",
        "<cmd>ToggleTerm direction=float<CR>",
        mode = "n",
        desc = "Toggle terminal (float)",
        silent = true,
      },
      {
        "<leader>jjw",
        "<cmd>ToggleTerm direction=tab<CR>",
        mode = "n",
        desc = "Toggle terminal (tab)",
        silent = true,
      },
    },
  },
}
