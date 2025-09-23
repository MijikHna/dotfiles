return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function ()
    require("barbar").setup()

    local keymap = vim.keymap

    keymap.set("n", "gt", "<cmd>BufferNext<CR>", { desc = "Buffer Next" })
    keymap.set("n", "gT", "<cmd>BufferPrevious<CR>", { desc = "Buffer Previous" })

    keymap.set("n", "<C-y>", "<cmd>BufferPick<CR>", { desc = "Buffer Pick Buffer", noremap = true })
    keymap.set("n", "<leader>bcb", "<cmd>BufferClose<CR>", { desc = "[B]uffer [C]lose [B]uffer" })
    keymap.set("n", "<leader>bpb", "<cmd>BufferPin<CR>", { desc = "[B]uffer [P]in [B]uffer" })

    keymap.set("n", "<leader>bsr", "<cmd>BufferScrollRight 80<CR>", { desc = "[B]uffer [S]croll to the [R]ight" })
    keymap.set("n", "<leader>bsl", "<cmd>BufferScrollLeft 80<CR>", { desc = "[B]uffer [S]croll to the [L]eft" })
    keymap.set("n", "<leader>bcc", "<cmd>BufferCloseAllButCurrent<CR>", { desc = "[B]uffer [C]lose All but [C]urrent" })
    keymap.set("n", "<leader>bcl", "<cmd>BufferCloseBuffersLeft<CR>", { desc = "[B]uffer [C]lose all to the [L]eft" })
    keymap.set("n", "<leader>bcr", "<cmd>BufferCloseBuffesRight<CR>", { desc = "[B]uffer [C]lose to the [R]ight" })
    keymap.set("n", "<leader>bcv", "<cmd>BufferCloseAllButVisible<CR>", { desc = "[B]uffer [C]lose but [V]isible" })
  end,
}
