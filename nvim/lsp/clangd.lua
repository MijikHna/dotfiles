local lsp_settings = require("utils.lsp_settings")

return {
  cmd = { "clangd", "-completion-style=detailed" },
  offset_enconding = "utf-16",
  filetypes = { "c", "cpp" },
  root_dir = function(bufnr, on_dir)
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == '' then return end

    -- Check if this file is inside an Arduino project
    local arduino_root = vim.fs.root(name, function(fname)
      return fname:match("%.ino$") or fname == "sketch.yaml"
    end)

    if arduino_root then return end

    -- Not an Arduino project → use standard clangd root detection
    local root = vim.fs.root(name, { "compile_commands.json", "compile_flags.txt", ".git" })
        or vim.fs.dirname(name)
    on_dir(root)
  end,
  capabilities = vim.tbl_extend("force", lsp_settings.capabilities, {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = { completion = { editsNearCursor = true }
    }
  })
}
