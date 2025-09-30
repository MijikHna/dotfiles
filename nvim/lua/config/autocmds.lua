local api = vim.api

api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("setlocal nospell")
  end
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "docker-compose*.yml", "docker-compose*.yaml" },
  callback = function()
    vim.cmd("set filetype=yaml.docker-compose")
  end,
})

api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.sls",
  callback = function()
    vim.cmd("set filetype=yaml")
  end
})


local conceallevel_markdown_group = api.nvim_create_augroup("ConcealLevelMarkdown", { clear = true })
api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = conceallevel_markdown_group,
  pattern = "*.md",
  callback = function()
    vim.cmd("setlocal conceallevel=1")
  end
})

-- Create an augroup for .env file settings
local env_group = vim.api.nvim_create_augroup("EnvFileConceal", { clear = true })

-- Set up autocmd for .env files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { ".env", "*.env", ".env.*" },
  group = env_group,
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt.concealcursor = "nvc"

    vim.schedule(function()
      vim.cmd([[
        syntax match EnvVarKey /\(^[^=]*=\)\@<=.*/ conceal cchar=
        highlight link EnvVarKey Conceal
      ]])
    end)
  end,
})

-- Auto Save
local autosave_group = vim.api.nvim_create_augroup("AutoSaveOnBufLeave", { clear = true })

vim.api.nvim_create_autocmd("BufLeave", {
  group = autosave_group,
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.api.nvim_get_option_value("modifiable", { buf = bufnr }) and vim.api.nvim_get_option_value("buftype", { buf = bufnr }) == "" then
      if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
        vim.cmd("write")
      end
    end
  end,
})
