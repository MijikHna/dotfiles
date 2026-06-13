local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
  init_options = {
    hostInfo = "neovim",
    preferences = { disableSuggestions = false },
  },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = "@vue/typescript-plugin",
            location = os.getenv("HOME") .. "/.nvm/versions/node/v22.17.0/lib/node_modules/@vue/language-server",
            languages = { "vue" },
            configNamespace = "typescript",
          }
        },
      },
    },
  },
  capabilites = lsp_settings.capabilities
}
