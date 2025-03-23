return {
  {
    "arnamak/stay-centered.nvim",
    enabled = false,
    config = function()
      local stay_centered = require("stay-centered")

      stay_centered.setup({})
      stay_centered.disable()

      vim.keymap.set({ "n", "v" }, "<leader>st", stay_centered.toggle, { desc = "Toggle stay-centered.nvim" })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    enabled = true,
    opts = {},
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled = false,
    opts = {
      stiffness = 0.4,
      trailing_stiffness = 0.4,
      never_draw_over_target = false,
    },
  }
}
