local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true },
  root_marker = { "package.json" },
  settings = {
    css = { validate = true },
    less = { validate = true },
    scss = { validate = true }
  },
  capabilities = vim.tbl_extend(
    "force",
    lsp_settings.capabilities,
    { textDocument = { completion = { completionItem = { snippetSupport = true } } } }
  ),
}
