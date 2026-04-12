local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "kotlin-language-server" },
  filetypes = { "kotlin" },
  name = "kotlin_language_server",
  root_markers = { "settings.gradle", "settings.gradle.kts", "build.xml", "pom.xml", "build.gradle", "build.gradle.kts" },
  capabilites = lsp_settings.capabilities

}
