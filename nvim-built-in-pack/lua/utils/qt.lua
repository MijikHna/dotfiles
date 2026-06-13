local Qt = {}

function Qt.get_qmlls_path()
  local qmlls_executable = os.getenv("HOME") .. "/prog/Qt/6.8.0/gcc_64/bin/qmlls"

  return qmlls_executable
end

return Qt
