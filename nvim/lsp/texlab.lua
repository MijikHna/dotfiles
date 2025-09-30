local lsp_settings = require("utils.lsp_settings")

return {
  cmd          = { "texlab" },
  filetypes    = { ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    texlab = {
      bibtexFormatter = "texlab",
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = false
      },
      chktex = { onEdit = false, onOpenAndSave = false },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = { args = {} },
      latexFormatter = "latexindent",
      latexindent = { modifyLineBreaks = false }
    }
  })
}
