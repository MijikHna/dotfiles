return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "alfaix/neotest-gtest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-python")({
          dap = { justMyCode = false },
          python = ".venv/bin/python",
          runner = "pytest",
          pytest_discover_instances = true,
          args = { "--log-level", "DEBUG" }
        }),
        require("neotest-gtest"),
      },
      discovery = { concurrent = 0, enabled = true },
      auto_close = true,
    })

    local keymap = vim.keymap

    keymap.set("n", "<leader>trn", neotest.run.run, { desc = "[T]est [R]un [N]earest" })
    keymap.set("n", "<leader>trf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "[T]est [R]un [F]ile" })
    keymap.set("n", "<leader>tdn", function() neotest.run.run({ strategy = "dap" }) end, { desc = "[T]est [D]ebug [N]earest" })
    keymap.set("n", "<leader>tst", neotest.run.stop, { desc = "[T]est [S]top [T]est" })

    keymap.set("n", "<leader>tts", neotest.summary.toggle, { desc = "[T]est [T]oggle Test [S]ummary" })
    keymap.set("n", "<leader>too", function() neotest.output.open({ enter = true }) end, { desc = "[T]est [O]pen [O]utput" })
    keymap.set("n", "<leader>top", neotest.output_panel.toggle, { desc = "[T]est [O]pen Output[P]anel" })
    keymap.set("n", "<leader>ttw", function() neotest.watch.toggle(vim.fn.expand("%")) end, { desc = "[T]est [T]oggle [W]atch" })
  end,
}
