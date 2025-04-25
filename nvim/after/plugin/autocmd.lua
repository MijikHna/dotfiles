-- save and restore folds
local function is_not_fold_buffer()
  local bufname = vim.api.nvim_buf_get_name(0)

  if bufname == nil or bufname == "" then
    return true
  end

  local file_stats = vim.uv.fs_stat(bufname)

  if file_stats == nil then
    return true
  end

  -- print(vim.bo.filetype == "help")
  -- print(vim.bo.filetype)

  return file_stats.type == "directory"
    or vim.bo.filetype == "toggleterm"
    or vim.bo.filetype == "NvimTree"
    or vim.bo.filetype == "dapui_console"
    or vim.bo.filetype == "dapui_scopes"
    or vim.bo.filetype == "dapui_breakpoints"
    or vim.bo.filetype == "dapui_stacks"
    or vim.bo.filetype == "dapui-repl"
    or vim.bo.filetype == "DiffviewFiles"
    or vim.bo.filetype == "help"
    or vim.bo.filetype == "dbout"
    or vim.bo.filetype == "dbui"
end
local fold_augroup = vim.api.nvim_create_augroup("Folds", { clear = true })

vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
  group = fold_augroup,
  pattern = "*",
  callback = function()
    if is_not_fold_buffer() then
      return
    end

    local ok, result = pcall(vim.api.nvim_exec2, "mkview", {})

    if not ok then
      vim.notify(vim.inspect(result), vim.log.levels.INFO)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
  group = fold_augroup,
  pattern = "?*",
  callback = function()
    if is_not_fold_buffer() then
      return
    end

    local ok, result = pcall(vim.api.nvim_exec2, "loadview", {})

    -- vim.cmd("loadview")
    if not ok then
      vim.notify(vim.inspect(result), vim.log.levels.INFO)
    end
  end,
})
