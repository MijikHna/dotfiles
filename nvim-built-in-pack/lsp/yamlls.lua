local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "yaml-language-server", "--stdio" },
  filetypes = { "yaml" },
  settings = {
    yaml = { keyOrdering = false, format = { enable = true } },
    redhat = { telemetry = { enabled = false } },
  },
  capabilities = lsp_settings.capabilities,
}
