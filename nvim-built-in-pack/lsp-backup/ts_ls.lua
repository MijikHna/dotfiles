local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    -- "vue",
  },
  -- plugins = {
  --   {
  --     name = "@vue/typescript-plugin",
  --     location = os.getenv("HOME") .. "/.nvm/versions/node/v22.17.0/lib/node_modules/@vue/typescript-plugin",
  --     languages = { "vue" },
  --     configNamespace = "typescript",
  --   },
  -- },
  capabilities = lsp_settings.capabilities
}
