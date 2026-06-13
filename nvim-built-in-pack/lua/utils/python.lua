local PythonUtil = {}

function PythonUtil.get_debug_python_exec()
  return os.getenv("HOME") .. "/prog/debugger/debugpy/.venv/bin/python"
end

function PythonUtil.get_python_venv_path()
  local cwd = vim.fn.getcwd()

  local exists = vim.loop.fs_stat(cwd .. "/.venv")

  if exists ~= nil then
    return cwd .. "/.venv"
  end

  return ""
end

function PythonUtil.get_venv_python_exec()
  local venv_path = PythonUtil.get_python_venv_path()
  if venv_path == "" then
    return "python3"
  end

  return venv_path .. "/bin/python"
end

return PythonUtil
