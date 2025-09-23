local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "clangd", "-completion-style=detailed" },
  offset_enconding = "utf-16",
  filetypes = { "c", "cpp" },
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = { completion = { editsNearCursor = true }
    }
  })
}
