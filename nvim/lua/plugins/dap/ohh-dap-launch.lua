return {
  "mijikhna/ohh-dap-launch.nvim",
  dev = false,
  enabled = true,
  -- dir = os.getenv("CODING") .. "/Projects/Nvim Plugins/ohh-dap-launch.nvim",
  build = function() require("ohh-dap-launch").install() end,
  dependencies = { "L3MON4D3/LuaSnip" },
  opts = {}
}
