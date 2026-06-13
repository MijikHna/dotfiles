local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "bash", "sh" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    }
  },
  capabilities = lsp_settings.capabilities
}
