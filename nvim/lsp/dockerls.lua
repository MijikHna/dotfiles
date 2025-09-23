local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_markers = { "Dockerfile" },
  capabilities = lsp_settings.capabilities
}
