local LspSettings = {}

LspSettings.capabilities = {
  workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
  offsetEncoding = { "utf-16" },
  general = { positionEncodings = { "utf-16" } },
  textDocument = {
    completion = { completionItem = { snippetSupport = false } },
    foldingRange = { dynamicRegistration = true, lineFoldingOnly = true }
  }
}

LspSettings.capabilities = require("blink.cmp").get_lsp_capabilities(LspSettings.capabilities)
return LspSettings
