local lsp_settings = require("utils.lsp_settings")
local arduino_util = require("utils.arduino")

return {
  cmd = {
    "arduino-language-server",
    "-clangd",
    "/usr/bin/clangd",
    "-cli",
    os.getenv("HOME") .. "/prog/arduino/arduino-cli/bin/arduino-cli",
    "-cli-config",
    os.getenv("HOME") .. "/.arduino15/arduino-cli.yml",
    "-fqbn",
    arduino_util.get_arduino_board_fqbn(),
  },
  filetypes = { "arduino" },
  name = "arduino_language_server",
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    {
      textDocument = { semanticTokens = vim.NIL },
      workspace = { semanticTokens = vim.NIL },
    }
  })

}
