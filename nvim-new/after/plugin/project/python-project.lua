local Path = require("plenary.path")
local scan_dir = require("plenary.scandir")

local api = vim.api
local levels = vim.log.levels

local function write_to_pyrightconfig()
  local pyrightconfig, error = io.open("pyrightconfig.json", "w")

  if not pyrightconfig then
    vim.notify("Error: Could not open pyrightconfig.json", levels.WARN)
    return
  end

  local pyright_obj = {
    venvPath = ".",
    venv = ".venv",
  }

  pyrightconfig:write(vim.json.encode(pyright_obj))

  pyrightconfig:close()
end

local function write_to_readme_md(project_name)
  local readme_md, error = io.open("README.md", "w")

  if not readme_md then
    vim.notify("Error: Could not open README.md", levels.WARN)
    return
  end

  readme_md:write("# " .. project_name .. "\n\n")
  readme_md:write("## Description\n\n")
  readme_md:write("## Dependencies\n\n")
  readme_md:write("## Build\n\n")
  readme_md:write("## Run\n\n")
  readme_md:write("## Test\n\n")
  readme_md:write("## License\n\n")

  readme_md:close()
end

local function write_to_requirements_txt()
  local requirements_txt, error = io.open("requirements.txt", "w")

  if not requirements_txt then
    vim.notify("Error: Could not open requirements.txt", levels.WARN)
    return
  end

  requirements_txt:write("#Testing\npytest\n")
  requirements_txt:write("#Notebooks\npynvim\njupytext\n\nnotebook\nipykernel\njupyter-client")

  requirements_txt:close()
end

local function create_conftest_py()
  local ok, fd = pcall(vim.uv.fs_open, "conftest.py", "w", 511)

  if not ok then
    vim.notify("Error: Could not create conftest.py", levels.WARN)
    return
  end

  vim.uv.fs_close(fd)
end

local function create_src_init_py(project_src_folder_name)
  local ok, fd = pcall(vim.uv.fs_open, project_src_folder_name .. "/__init__.py", "w", 511)

  if not ok then
    vim.notify("Error: Could not create " .. project_src_folder_name .. "/__init__.py", levels.WARN)
    return
  end

  vim.uv.fs_close(fd)
end

local function create_main_py(current_dir)
  local ok, main_py = pcall(vim.uv.fs_open, current_dir .. "/main.py", "w", 511)

  if not ok then
    vim.notify("Error: Could not create main.py", levels.WARN)
    return
  end

  local main_content = "def main():\n    print('Hello, World!')\n\nif __name__ == '__main__':\n    main()\n\n\n"

  local ok, _ = pcall(vim.uv.fs_write, main_py, main_content)

  if not ok then
    vim.notify("Error: Could not write to .prettierrc", levels.WARN)
    return
  end

  local ok, _ = pcall(vim.uv.fs_close, main_py)

  if not ok then
    vim.notify("Error: Could not close .prettierrc", levels.WARN)
    return
  end
end

local function create_pyproject_toml(project_name)
  local pyproject_toml, error = io.open("pyproject.toml", "w")

  if not pyproject_toml then
    vim.notify("Error: Could not open pyproject.toml", levels.WARN)
    return
  end


  local quoted_deps = {
    '    # Testing',
    '    "pytest",',
    '    # Notebooks',
    '    "pynvim",',
    '    "jupytext",',
    '    "notebook",',
    '    "ipykernel",',
    '    "jupyter-client"'
  }
  local deps_str = table.concat(quoted_deps, '\n')

  local toml_content = string.format([[
[project]
name = "%s"
version = "0.1.0"
description = ""
dependencies = [
%s
]
[build-system]
requires = ["hatchling>=1.0.0"]
build-backend = "hatchling.build"

[tool.pyright]
venvPath = "."
venv = ".venv"
]], project_name, deps_str)

  pyproject_toml:write(toml_content)
  pyproject_toml:close()
end
local function create_python_project()
  --[[
  -- ROOT/
  -- ├── src/
  -- ├── tests/
  -- ├── pyrightconfig.json
  -- ├── README.md
  -- ├── requirements.txt
  -- ├── pyproject.toml
  --]]
  --
  local python_project_path = Path:new(".")
  local project_name_splitted = vim.split(python_project_path:absolute(), "/")
  local project_name = project_name_splitted[#project_name_splitted]
  local project_src_folder_name = project_name:gsub("%s+", "_"):lower()

  local files = scan_dir.scan_dir(python_project_path:absolute(), { depth = 1, add_dirs = true })

  if #files > 0 then
    vim.notify("Directory is not empty, C++ project can't be created here")
    return
  end

  -- create directories
  vim.uv.fs_mkdir(python_project_path:absolute() .. "/" .. project_src_folder_name, 511)
  vim.uv.fs_mkdir(python_project_path:absolute() .. "/tests", 511)

  -- create files
  create_conftest_py()
  create_src_init_py(project_src_folder_name)
  -- write_to_pyrightconfig()
  write_to_readme_md(project_name)
  -- write_to_requirements_txt()
  create_main_py(python_project_path:absolute())
  create_pyproject_toml(project_name)

  vim.cmd("NvimTreeRefresh")
end

local function create_python_notebook(opts)
  local filename = opts.args

  if not filename:match("%.ipynb$") then
    vim.notify("Only .ipynb files are allowed", vim.log.levels.ERROR)
    return
  end

  local notebook_file_handler = Path:new(".", filename)

  local notebook_init_content = {
    cells = {},
    metadata = {
      file_extension = ".py",
      kernelspec = {
        display_name = "Python 3 64-bit ('.venv')",
        language = "python",
        name = "python3",
      },
      language_info = {
        codemirror_mode = {
          name = "ipython",
          version = 3,
        },
        name = "python",
      },
      mimetype = "text/x-python",
      name = "python",
      npconvert_exporter = "python",
      pygments_lexer = "ipython3",
      version = 3,
    },
    nbformat = 4,
    nbformat_minor = 2,
  }

  notebook_file_handler:write(vim.json.encode(notebook_init_content), "a")
  notebook_file_handler:close()
end

api.nvim_create_user_command("CreatePythonProject", create_python_project, {})
api.nvim_create_user_command("CreatePythonNotebook", create_python_notebook, { nargs = 1 })
