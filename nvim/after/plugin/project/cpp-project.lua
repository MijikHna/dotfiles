local Path = require("plenary.path")
local scan_dir = require("plenary.scandir")

local api = vim.api
local levels = vim.log.levels

local function write_to_gitignore()
  local gitignore_file, error = io.open(".gitignore", "w")

  if not gitignore_file then
    vim.notify("Error: Could not open .gitignore", levels.WARN)
    return
  end

  --TODO: curl https://www.gitignore.io/api/c++ > .gitignore
  --
end

local function write_to_cmakelists(project_name)
  local cmake_file, error = io.open("CMakeLists.txt", "w")

  if not cmake_file then
    vim.notify("Error: Could not open CMakeLists.txt", levels.WARN)
    return
  end

  cmake_file:write("cmake_minimum_required(VERSION 3.10)\n\n")
  cmake_file:write("project(" .. project_name .. " VERSION 0.1.0)\n\n")
  cmake_file:write("set(CMAKE_CXX_STANDARD 20)\n")
  cmake_file:write("set(CMAKE_EXPORT_COMPILE_COMMANDS ON)\n\n")
  cmake_file:write("include_directories(${CMAKE_SOURCE_DIR}/include)\n\n")
  cmake_file:write("add_executable(${PROJECT_NAME} main.cpp)\n\n")

  cmake_file:close()
end

local function write_to_makefile(project_name)
  local makefile, error = io.open("Makefile", "w")

  if not makefile then
    vim.notify("Error: Could not open Makefile", levels.WARN)
    return
  end

  makefile:write("SRC = src\n")
  makefile:write("INCLUDE = include\n\n")

  makefile:write("run: build\n")
  makefile:write("\t./build/" .. project_name .. "\n\n")

  makefile:write("run-debug: build\n")
  makefile:write("\t./build/" .. project_name .. "\n\n")

  makefile:write("build-debug: $(SRC)/*.cpp $(INCLUDE)/*.hpp main.cpp CMakeLists.txt\n")
  makefile:write("\tcmake --build ./build --config Debug --target " .. project_name .. "\n\n")

  makefile:write("build: $(SRC)/*.cpp $(INCLUDE)/*.hpp main.cpp CMakeLists.txt\n")
  makefile:write("\tcmake --build ./build --config Release --target " .. project_name .. "\n\n")

  makefile:write("clean:\n")
  makefile:write("\trm -rf build\n\n")

  makefile:write("setup-debug:\n")
  makefile:write("\tcmake -S . -DCMAKE_BUILD_TYPE:STRING=Debug -B ./build \n\n")

  makefile:write("setup:\n")
  makefile:write("\tcmake -S . -DCMAKE_BUILD_TYPE:STRING=Release -B ./build")

  makefile:close()
end

local function write_to_vcpkg_json(project_name)
  local vcpkg_json, error = io.open("vcpkg.json", "w")

  if not vcpkg_json then
    vim.notify("Error: Could not open vcpkg.json", levels.WARN)
    return
  end

  local vcpkg_obj = {
    name = project_name,
    version = "0.1.0",
    dependencies = {},
  }

  vcpkg_json:write(vim.json.encode(vcpkg_obj))

  vcpkg_json:close()
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

local function write_to_main_cpp()
  local main_cpp, error = io.open("main.cpp", "w")

  if not main_cpp then
    vim.notify("Error: Could not open main.cpp", levels.WARN)
    return
  end

  main_cpp:write("#include <cstdlib>\n\n")
  main_cpp:write("int main() {\n")
  main_cpp:write("\treturn EXIT_SUCCESS;\n")
  main_cpp:write("}\n")

  main_cpp:close()
end

local function copy_cmake_presets_and_clang_format()
  local dotfiles_dir = os.getenv("HOME") .. "/.dotfiles"

  vim.uv.fs_copyfile(dotfiles_dir .. "/presets/.clang-format", vim.fn.getcwd() .. "/.clang-format")
  vim.uv.fs_copyfile(dotfiles_dir .. "/presets/CMakePresets.json", vim.fn.getcwd() .. "/CMakePresets.json")
  vim.uv.fs_copyfile(dotfiles_dir .. "/presets/.clangd", vim.fn.getcwd() .. "/.clangd")
end

local function create_cpp_project()
  --[[
  --  ROOT/
  --  ├── build/
  --  ├── data/
  --  ├── include/
  --  ├── src/
  --  ├── test/
  --  ├── .gitignore
  --  ├── CMakeLists.txt
  --  ├── Makefile
  --  ├── README.md
  --  ├── main.cpp
  --  ├── vcpkg.json
  --  └── .clang-format
  --]]
  local dotfiles_path = Path:new(os.getenv("HOME") .. "../.dotfiles")
  local cpp_project_path = Path:new(".")
  local cpp_project_splitted_path = vim.split(cpp_project_path:absolute(), "/")
  local cpp_project_name = cpp_project_splitted_path[#cpp_project_splitted_path]

  -- if directory is not empty print error message and return
  local files = scan_dir.scan_dir(cpp_project_path:absolute(), { depth = 1, add_dirs = true })

  if #files > 0 then
    vim.notify("Directory is not empty, C++ project can't be created here")
    return
  end

  -- create directories
  vim.uv.fs_mkdir(cpp_project_path:absolute() .. "/build", 511)
  vim.uv.fs_mkdir(cpp_project_path:absolute() .. "/data", 511)
  vim.uv.fs_mkdir(cpp_project_path:absolute() .. "/include", 511)
  vim.uv.fs_mkdir(cpp_project_path:absolute() .. "/src", 511)
  vim.uv.fs_mkdir(cpp_project_path:absolute() .. "/test", 511)

  vim.uv.fs_copyfile(dotfiles_path .. "/presets/.clang-format", cpp_project_path:absolute() .. "/.clang-format")
  vim.uv.fs_copyfile(dotfiles_path .. "/presets/CMakePresets.json", cpp_project_path:absolute() .. "/CMakePresets.json")
  vim.uv.fs_copyfile(dotfiles_path .. "/presets/.clangd", cpp_project_path:absolute() .. "/.clangd")

  -- write to files
  --.gitingore
  -- write_to_gitignore()
  -- CMakeLists.txt
  write_to_cmakelists(cpp_project_name)
  -- Makefile
  write_to_makefile(cpp_project_name)
  -- vcpkg.json
  write_to_vcpkg_json(cpp_project_name)
  -- README.md
  write_to_readme_md(cpp_project_name)
  -- main.cpp
  write_to_main_cpp()

  copy_cmake_presets_and_clang_format()

  vim.cmd("NvimTreeRefresh")
end

api.nvim_create_user_command("CreateCppProject", create_cpp_project, {})
api.nvim_create_user_command("CreateCMakePresetsAndClangFormat", copy_cmake_presets_and_clang_format, {})
