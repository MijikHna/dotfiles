local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "rust-analyzer" },
  settings = { ["rust-analyzer"] = { diagnostics = { enable = false } } },
  filetypes = { "rust" },
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    experimental = { serverStatusNotification = true }
  })
}
