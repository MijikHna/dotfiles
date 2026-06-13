-- unknown
vim.pack.add({"https://www.github.com/nvim-lua/plenary.nvim"})
vim.pack.add({"https://www.github.com/nvim-tree/nvim-web-devicons"})

-- blink
vim.pack.add(
  {
    {
      src = "https://www.github.com/saghen/blink.compat",
      version = "*",
    }
  }
)
vim.pack.add({"https://www.github.com/onsails/lspkind.nvim"})
vim.pack.add(
  {
    {
      src = "https://github.com/L3MON4D3/LuaSnip",
      version = vim.version.range("2.0")
    }
  }
)
vim.pack.add({"https://github.com/rafamadriz/friendly-snippets"})

require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
  paths = { vim.fn.stdpath("config") .. "/nvim/my-snippets" },
})

vim.pack.add({"https://www.github.com/rcarriga/cmp-dap"})
vim.pack.add({"https://www.github.com/kristijanhusak/vim-dadbod-completion"})
-- vim.pack.add({"Kaiser-Yang/blink-cmp-avante}")
