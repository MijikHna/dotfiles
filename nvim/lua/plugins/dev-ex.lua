return {
  "arnamak/stay-centered.nvim",
  enabled = false,
  config = function()
    local stay_centered = require("stay-centered")

    stay_centered.setup({})
    stay_centered.disable()

    vim.keymap.set({ "n", "v" }, "<leader>st", stay_centered.toggle, { desc = "Toggle stay-centered.nvim" })
  end,
}
