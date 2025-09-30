PRINT_DEBUG = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function(...)
  require("plenary.reload").reload_module(...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end

RELOAD_DEBUG = function(name)
  require("plenary.reload").reload_module(name)
  return require(name)
end

vim.api.nvim_create_user_command('ReloadDebug', function(opts)
  if opts.args == nil then
    vim.notify("No Module Name provided, skipping reload ...", vim.log.levels.WARN);
    return
  end

  vim.notify("Reloading " .. opts.args)
  RELOAD_DEBUG(opts.args)
end, {
  nargs = 1,
  desc = 'Reload a Lua module and return it'
})

vim.keymap.set({ "n" }, "rlp", "<cmd>PlenaryButstedFile", { desc = "[Run] Test in Current Buffer for [L]ua [P]luging" })
