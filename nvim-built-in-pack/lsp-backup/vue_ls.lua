local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "vue-language-server", "--stdio" },
  filetypes = { "vue" },
  root_markers = { "package.json" },
  init_options = {
    typescript = {
      tsdk = os.getenv("HOME") .. "/.nvm/versions/node/v22.17.0/lib/node_modules/typescript/lib"
    },
    vue = { hybridMode = false }
  },
  capabilities = lsp_settings.capabilities
}
