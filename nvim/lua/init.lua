local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.colorschema" },
  { import = "plugins.dap" },
  -- { import = "plugins.git" },
  { import = "plugins.lsp" },
  { import = "plugins.test" },
}, {
  change_detection = {
    notify = false,
  },
  checker = {
    enable = false,
    notify = false,
  },
})
