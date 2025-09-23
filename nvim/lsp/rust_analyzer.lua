local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "rust-analyzer" },
  settings = { ["rust-analyzer"] = { diagnostics = { enable = true } } },
  filetypes = { "rust" },
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = false;
      }
    }
  },
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    experimental = { serverStatusNotification = true }
  })
}
