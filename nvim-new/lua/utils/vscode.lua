local VsCodeUtil = {}

function VsCodeUtil.find_vscode_cpptools()
  local cpp_tools_versions = {}
  local vs_code_extentions_dir = os.getenv('HOME') .. '/.vscode/extensions'
  local dir = io.popen('ls -a "' .. vs_code_extentions_dir .. '"')

  for filename in dir:lines() do
    if (filename:sub(1, #'ms-vscode.cpptools') == 'ms-vscode.cpptools' and filename:sub(- #'linux-x64') == 'linux-x64') then
      table.insert(cpp_tools_versions, filename)
    end
  end

  if #(cpp_tools_versions) == 0 then
    return ''
  end
  table.sort(cpp_tools_versions)

  return cpp_tools_versions[#cpp_tools_versions]
end

return VsCodeUtil
