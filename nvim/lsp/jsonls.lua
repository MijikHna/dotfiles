local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  init_opitons = { provideFormatter = true },
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities,
    { textDocument = { completion = { completionItem = { snippetSupport = true } } } })
}
