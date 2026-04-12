vim.defer_fn(function()
  vim.opt.scrolloff = 22
  vim.opt.laststatus = 3
end, 100)

vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo[0][0].foldmethod = 'expr'
