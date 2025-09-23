local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ" },
  capabilities = vim.tbl_extend(
    "force",
    lsp_settings.capabilities,
    { textDocument = { completion = { completionItem = { snippetSupport = true } } } }
  ),
}
