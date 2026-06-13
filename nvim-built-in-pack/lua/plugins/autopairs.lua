vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

local autopairs = require("nvim-autopairs")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")

autopairs.setup({
  check_ts = true, -- enable treesitter
  ts_config = {
    lua = { "string" },
    javascript = { "template_string" },
    java = false,
  },
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

-- vim.pack.add({"https://github.com/windwp/nvim-ts-autotag" })
-- vim.pack.add({"https://github.comechasnovski/mini.surround" })
