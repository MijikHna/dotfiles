local lsp_settings = require("utils.lsp_settings")
local arduino_util = require("utils.arduino")

local capabilities = vim.deepcopy(lsp_settings.capabilities)
capabilities.textDocument.semanticTokens = vim.NIL
capabilities.workspace.semanticTokens = vim.NIL

return {
  cmd = {
    "arduino-language-server",
    "-clangd", "clangd",
    "-cli", "arduino-cli",
    "-cli-config", vim.fn.expand("/.arduino15/arduino-cli.yml"),
    "-fqbn", arduino_util.get_arduino_board_fqbn(),
  },
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)

    if name == '' then return end

    local root = vim.fs.root(name, function(fname)
      return fname:match("%.ino$") or fname == "sketch.yaml"
    end)

    if root then
      on_dir(root)
    end
  end,
  filetypes = { "arduino", "hpp", "cpp", "c", "h" },
  name = "arduino_language_server",
  capabilities = capabilities,
}
