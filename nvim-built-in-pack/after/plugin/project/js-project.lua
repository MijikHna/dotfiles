local levels = vim.log.levels
local api = vim.api

local function write_prettier(current_dir)
  local ok, prettierrc = pcall(vim.uv.fs_open, current_dir .. "/.prettierrc", "w", 511)

  if not ok then
    vim.notify("Error: Could not create .prettierrc", levels.WARN)
    return
  end

  local prettier_obj = {
    semi = true,
    singleQuote = false,
    trailingComma = "es5",
    tabWidth = 2
  }

  local ok, prettierrc_write = pcall(vim.uv.fs_write, prettierrc, vim.json.encode(prettier_obj))

  if not ok then
    vim.notify("Error: Could not write to .prettierrc", levels.WARN)
    return
  end

  local ok, prettierrc_close = pcall(vim.uv.fs_close, prettierrc)

  if not ok then
    vim.notify("Error: Could not close .prettierrc", levels.WARN)
    return
  end
end

local function write_to_eslint(current_dir)
  local ok_fs_open, eslint = pcall(vim.uv.fs_open, current_dir .. "/.eslint.config.js", "w", 511)

  if not ok_fs_open then
    vim.notify("Error: Could not create .eslintrc.json", levels.WARN)
    return
  end

  local eslint_obj = {
    extends = "eslint:recommended",
    rules = {
      semi = { "warn", "always" },
      indent = { "warn", 2 },
      quotes = { "warn", "double" },
    }
  }

  -- NOTE: Maybe possible to write serialized
  local ok_fs_write, eslint_write = pcall(
    vim.uv.fs_write,
    eslint,
    "export default [" .. vim.json.encode(eslint_obj) .. "]",
    -1
  )
  if not ok_fs_write then
    vim.notify("Error: Could not write to .eslintrc.json", levels.WARN)
    return
  end

  local ok_fs_close, eslint_close = pcall(vim.uv.fs_close, eslint)

  if not ok_fs_close then
    vim.notify("Error: Could not close .eslintrc.json", levels.WARN)
    return
  end
end


local function create_eslint_and_prettier_configs()
  local ok, current_dir = pcall(vim.fn.getcwd)

  if not ok then
    vim.notify("Error: Could not get current directory", levels.WARN)
    return
  end

  -- local stat = vim.fs_stat(current_dir .. "/.prettierrc")
  local prettierrc_file = vim.fs.find(".prettierrc", { path = current_dir })

  if #prettierrc_file == 0 then
    write_prettier(current_dir)
  end

  local eslint_file = vim.fs.find("eslint.config.json", { path = current_dir })

  if #eslint_file == 0 then
    write_to_eslint(current_dir)
  end

  vim.notify(
    "Created .prettierrc and .eslint.config.json"
      .. "Execute: \n"
      .. "Vanilla JS/TS: \"npm install -D eslint prettier eslint-config-prettier\"\n"
      .. "Vue: \"npm install -D eslint prettier eslint-config-prettier eslint-plugin-vue\"",
    levels.INFO)
end

api.nvim_create_user_command("CreateEslintandPrettierConfigs", create_eslint_and_prettier_configs, {})
