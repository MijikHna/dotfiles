-- LSP Servers
vim.lsp.enable("lua_ls")

vim.lsp.enable("ts_ls") -- npm
-- vim.lsp.enable("vue_ls") -- npm
-- vim.lsp.enable("vtsls")

vim.lsp.enable("clangd")
vim.lsp.enable("cmake")   -- pip

vim.lsp.enable("pyright") -- nvim

vim.lsp.enable("kotlin_ls")

vim.lsp.enable("bashls")   -- requries specllchecker (apt) and bash-language-server (npm)

vim.lsp.enable("cssls")    -- vscode-langservers-extracted (npm)
vim.lsp.enable("html")     -- vscode-langservers-extracted (npm)
vim.lsp.enable("jsonls")   -- vscode-langservers-extracted (npm)

vim.lsp.enable("emmet_ls") -- npm

vim.lsp.enable("dockerls")
vim.lsp.enable("docker_compose_ls")
vim.lsp.enable("yamlls")     -- npm

vim.lsp.enable("arduino_ls") -- requires arduino-cli
vim.lsp.enable("rust_analyzer")

-- vim.lsp.enable("qmlls")
vim.lsp.enable("texlab")

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
      [vim.diagnostic.severity.HINT] = "HintMsg",
      [vim.diagnostic.severity.INFO] = "InfoMsg",
    },
  },
  virtual_text = true,
  virtual_lines = false,
  underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } },
})

local keymap = vim.keymap

keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinitions" })
keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [[D]]eclaration " })
keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]o to [[I]]mplementations" })

keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "[G]o to Code [A]ctions" })
keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature" })
keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "[G]o how [S]ignature" })
keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "[H]over" })
keymap.set("n", "gp", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "[G]o to [P]revious Diagnostics" })
keymap.set("n", "gn", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "[G]o to [N]ext Diagnostics" })

keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "[G]o to [R]ename" })

keymap.set("n", "go", vim.lsp.buf.outgoing_calls, { desc = "[G]o [O]utgoing Calls" })
keymap.set("n", "gi", vim.lsp.buf.incoming_calls, { desc = "[G]o [I]ncoling Calls" })

keymap.set("n", "gf", vim.diagnostic.open_float, { desc = "[G]o to [F]loat Window Diagnostics" })

vim.keymap.set("n", "gv", function()
  vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
    callback = function()
      vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
      return true
    end,
  })
end, { desc = " [G]o to [V]irtual Lines" })


-- :LspClients  → list names
vim.api.nvim_create_user_command("LspClients", function()
  local names, seen = {}, {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if not seen[client.name] then
      table.insert(names, client.name); seen[client.name] = true
    end
  end
  print(#names > 0 and ("Attached LSPs: " .. table.concat(names, ", ")) or "No LSP clients attached")
end, {})

-- :LspInfo  → a bit more detail
vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    print("No LSP clients attached"); return
  end
  for _, client in ipairs(clients) do
    local root = (client.config and client.config.root_dir) or "?"
    print(string.format("• %s (id:%d) root:%s", client.name, client.id, root))
  end
end, {})

-- completion helper for attached names
local function attached_names()
  local out, seen = {}, {}
  for _, clients in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if not seen[clients.name] then
      table.insert(out, clients.name); seen[clients.name] = true
    end
  end
  return out
end

-- :LspStop <name>
vim.api.nvim_create_user_command("LspStop", function(opts)
  local name, stopped = opts.args, false
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.name == name then
      client:stop(); stopped = true
    end
  end
  print(stopped and ("Stopped LSP: " .. name) or ("No client '" .. name .. "' on this buffer"))
end, { nargs = 1, complete = attached_names })

-- :LspStart <name>
vim.api.nvim_create_user_command("LspStart", function(opts)
  local name = opts.args
  local ok, err = pcall(vim.lsp.enable, name)
  print(ok and ("Started LSP: " .. name) or ("Could not start '" .. name .. "': " .. tostring(err)))
end, { nargs = 1 })

-- :LspRestart <name>
vim.api.nvim_create_user_command("LspRestart", function(opts)
  local name, had = opts.args, false
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    if client.name == name then
      client:stop(); had = true
    end
  end
  local ok, err = pcall(vim.lsp.enable, name)
  if ok then
    print((had and "Restarted " or "Started ") .. name)
  else
    print("Restart failed for '" .. name .. "': " .. tostring(err))
  end
end, { nargs = 1, complete = attached_names })


vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd("edit " .. vim.lsp.get_log_path())
end, {})
