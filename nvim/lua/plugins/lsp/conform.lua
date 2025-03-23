return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- yaml = { "prettier" },
        -- markdown = { "prettier" },
        -- python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 700,
      })
    end, { desc = "Format file or range (in visual mode)" })

    vim.keymap.set("n", "<C-s>", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 700,
      })
      vim.cmd("write")
    end, { desc = "Format file" })
  end,
}
