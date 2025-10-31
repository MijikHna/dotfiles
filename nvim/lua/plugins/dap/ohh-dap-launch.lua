return {
  "mijikhna/ohh-dap-launch.nvim",
  dev = true,
  enabled = true,
  dir = os.getenv("CODING") .. "/Projects/Nvim Plugins/ohh-dap-launch.nvim",
  build = function() require("ohh-dap-launch").install() end,
  opts = {}
}
