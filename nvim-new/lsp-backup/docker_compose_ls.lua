local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "docker-compose-langserver", "--stdio" },
  filetypes = { "yaml.docker-compose" },
  name = "docker_compose_language_server",
  root_markers = {
    "docker-compose.yaml",
    "docker-compose.yml",
    "compose.yaml",
    "compose.yml"
  },
  capabilities = lsp_settings.capabilities,
}
