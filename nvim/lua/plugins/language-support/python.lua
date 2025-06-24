return {
  {
    -- converts ipynb to python or markdown files for editing
    {
      "GCBallesteros/jupytext.nvim",
      enabled = true,
      opts = {
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      },
    },
    {
      "quarto-dev/quarto-nvim",
      dependencies = {
        "jmbuhr/otter.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      ft = { "quarto", "markdown" },
      opts = {
        lspFeatures = {
          enabled = true,
          languages = { "python" },
          chunks = "all",
          diagnostics = { enabled = true, triggers = { "BufWritePost" } },
          completion = { enabled = true },
        },
        codeRunner = { enabled = true, default_method = "molten" },
      },
      init = function ()
        local runner = require("quarto.runner")

        local keymap = vim.keymap

        local function run_all()
          runner.run_all(true)
        end

        keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
        keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
        keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
        keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
        keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
        keymap.set("n", "<localleader>RA", run_all, { desc = "run all cells of all languages", silent = true })
      end,
    },
    -- navigating through cells
    {
      "GCBallesteros/vim-textobj-hydrogen",
      enabled = false,
      dependencies = {
        "kana/vim-textobj-user",
      },
    },
    {
      -- READ THE MANUAL <https://github.com/benlubas/molten-nvim/blob/main/docs/Not-So-Quick-Start-Guide.md>
      "benlubas/molten-nvim",
      enabled = true,
      build = ":UpdateRemotePlugins",
      init = function ()
        vim.g.molten_output_win_max_height = 12
        vim.g.molten_wrap_output = true
        vim.g.molten_virt_text_output = true
        vim.g.molten_virt_lines_off_by_1 = true
      end,
    },
  },
}
