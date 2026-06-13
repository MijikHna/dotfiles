local M = {}

function M.get_arduino_board_fqbn()
  -- read sketch.yaml file and get fqbn from it
  local sketch_yaml = io.open("sketch.yaml", "r")

  if sketch_yaml == nil then
    return ""
  end

  local board_fqbn = ""

  for line in sketch_yaml:lines() do
    if line:sub(1, #"default_fqbn:") == "default_fqbn:" then
      board_fqbn = line:sub(#"default_fqbn:" + 2)
      break
    end
  end

  vim.notify("Arduino LSP: Board Found -> " .. board_fqbn)
  return board_fqbn
end

return M
