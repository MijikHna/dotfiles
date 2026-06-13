local levels = vim.log.levels
local api = vim.api

local function create_makefile(current_dir)
  local makefile, error = io.open(current_dir .. "/makefile", "w")
  if not makefile then
    vim.notify("Error: Could not open Makefile", levels.WARN)
    return
  end

  -- TODO: figure out proper javac and java commands and parameters
  makefile:write("SRC = src/main/java/com/mijikhna/app\n\n")
  makefile:write("CLASS_PATH = target\n")
  makefile:write("TARGET = main.java.com.mijikhna.app.Main\n\n")

  makefile:write("run: build\n")
  makefile:write("\t java -cp $(CLASS_PATH) $(TARGET)\n\n")

  makefile:write("build: $(SRC)*.java pom.xml\n")
  makefile:write("\tjavac -d ./target $(SRC)*.java\n\n")

  makefile:write("clean:\n")
  makefile:write("\trm -rf target\\*\n\n")

  makefile:close()
end

local function create_java_project()
  local ok, current_dir = pcall(vim.fn.getcwd)

  if not ok then
    vim.notify("Error: Could not get current directory", levels.WARN)
    return
  end


  -- check if folder is empty

  local userdata, err = vim.uv.fs_scandir(current_dir)

  print(vim.inspect(userdata))


  local file_handler, err = vim.uv.fs_open(current_dir .. "/pom.xml", "w", 511)

  if not file_handler then
    vim.notify("Error: Could not create pom.xml", levels.WARN)
    return
  end

  ok = vim.uv.fs_close(file_handler)

  if not ok then
    vim.notify("Error: Could not close pom.xml", levels.WARN)
    return
  end

  ok = vim.uv.fs_mkdir(current_dir .. "/src", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/main", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/main/java", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/main/java/com", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/main/java/com/mijikhna", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/main/java/com/mijikhna/app", 511)

  file_handler, err = vim.uv.fs_open(current_dir .. "/src/main/java/com/mijikhna/app/Main.java", "w", 511)
  if not ok then
    vim.notify("Error: Could not create Main.java", levels.WARN)
    return
  end

  ok = vim.uv.fs_write(file_handler, "package main.java.com.mijikhna.app;\n")
  ok = vim.uv.fs_write(file_handler, "public class Main {\n")
  ok = vim.uv.fs_write(file_handler, "\tpublic static void main(String[] args) {\n")
  ok = vim.uv.fs_write(file_handler, "\t}\n")
  ok = vim.uv.fs_write(file_handler, "}")
  ok = vim.uv.fs_close(file_handler)

  ok = vim.uv.fs_mkdir(current_dir .. "/src/main/resources", 511)

  ok = vim.uv.fs_mkdir(current_dir .. "/src/test", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/test/java", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/test/java/com", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/test/java/com/mijikhna", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/test/java/com/mijikhna/app", 511)
  ok = vim.uv.fs_mkdir(current_dir .. "/src/test/resources", 511)

  ok = vim.uv.fs_mkdir(current_dir .. "/target", 511)

  create_makefile(current_dir)
end


api.nvim_create_user_command("CreateJavaProject", create_java_project, {})
