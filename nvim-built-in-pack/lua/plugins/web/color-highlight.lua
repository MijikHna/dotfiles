vim.pack.add("https://www.github.com/uga-rosa/ccc.nvim")
vim.pack.add(
  { "https://www.github.com/brenoprata10/nvim-highlight-colors" },
  {
    render = "virtual",
    virtual_symbol_position = "eow",
    virtual_symbol_prefix = " ",
    virtual_symbol_suffix = "",
    exclude_filetypes = { "lazy" },
    enable_var_usage = false,
  }
)

vim.pack.add("https://www.github.com/norcalli/nvim-colorizer.lua")
