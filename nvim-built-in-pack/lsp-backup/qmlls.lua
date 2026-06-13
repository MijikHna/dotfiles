local qt = require("utils.qt")
local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { qt.get_qmlls_path() },
  filetypes = { "qml", "qmljs" },
  capabilites = lsp_settings.capabilities,
}
