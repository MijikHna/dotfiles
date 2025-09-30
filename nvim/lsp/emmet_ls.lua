local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = {
    "astro",
    "css",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "svelte",
    "templ",
    "typescriptreact",
    "vue"
  },
  capbilities = lsp_settings.capabilities
}
