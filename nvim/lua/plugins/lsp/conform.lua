return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      vue = { "prettier" },
      react = { "prettier" },
      typescriptreact = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      xml = { "xmllint" }
    },
  },
  init = function()
    local conform = require("conform")

    vim.keymap.set(
      { "n", "v" },
      "<leader>fl",
      function() conform.format({ lsp_fallback = true, async = false, timeout_ms = 500 }) end,
      { desc = "Format file or range (in visual mode)" }
    )

    vim.keymap.set("n", "<C-s>",
      function()
        conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
        vim.cmd("write")
      end,
      { desc = "Format file" }
    )
  end,
}
