return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  enabled = false,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    workspaces = { },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
    },
    ui = { enable = false },
    templates = {
      folder = "$templates",
      date_format = "%d.%m.%Y",
      time_format = "%H:%M",
      substitutions = { {} }, -- A map for custom variables, the key should be the variable and the value a function
    },
    attachments = { img_folder = "$assets/images" },
  },
}
