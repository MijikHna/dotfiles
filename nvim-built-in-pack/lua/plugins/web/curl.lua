vim.pack.add("https://www.github.com/oysandvik94/curl.nvim")

local curl = require("curl")

curl.setup({ open_with = "tab" })

vim.keymap.set("n", "<leader>cr", curl.execute_curl, { noremap = true, desc = "Run Curl under Cursor" })
