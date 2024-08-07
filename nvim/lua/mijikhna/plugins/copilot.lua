return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_filetypes = { markdown = true, DressingInput = false }

      local keymap = vim.keymap

      keymap.set("i", "<C-Q>", "copilot#Accept('\\<CR>')", { expr = true, replace_keycodes = false })
      keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
      keymap.set("i", "<C-J>", "<Plug>(copilot-accept-line)")
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    opts = {
      context = "buffer"
    },
    init = function()
      vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>")
    end
  }
}
