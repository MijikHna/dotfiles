local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json", "pyproject.toml", "requirements.txt", "setup.py", "setup.cfg" },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = true
      }
    }
  },
  capabilities = lsp_settings.capabilities

}
