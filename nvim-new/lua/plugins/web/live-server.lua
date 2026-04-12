-- requires: npm install -g browser-sync - currently uninstalled
vim.pack.add(
  { "https:/www.github.com/ray-x/web-tools.nvim" },
  {
    keymaps = { rename = nil },
    hurl = {                -- hurl default
      show_headers = false, -- do not show http headers
      floating = false,     -- use floating windows (need guihua.lua)
      formatters = { json = { "jq" }, html = { "prettier", "--parser", "html" } },
    }
  }
)
