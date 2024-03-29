require('CopilotChat').setup {
  opts = {
    mode = "split",   -- newbuffer or split  , default: newbuffer
  },
  build = function()
    vim.defer_fn(function()
      vim.cmd("UpdateRemotePlugins")
      vim.notify("CopilotChat - Updated remote plugins. Please restart Neovim.")
    end, 3000)
  end,
  prompts = {
    Explain = "Explain how it works.",
    Review = "Review the following code and provide concise suggestions.",
    Tests = "Briefly explain how the selected code works, then generate unit tests.",
    Refactor = "Refactor the code to improve clarity and readability.",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>cce", "<cmd>CopilotChatExplain<cr>",  desc = "CopilotChat - Explain code" },
    { "<leader>cct", "<cmd>CopilotChatTests<cr>",    desc = "CopilotChat - Generate tests" },
    { "<leader>ccr", "<cmd>CopilotChatReview<cr>",   desc = "CopilotChat - Review code" },
    { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
  },
}
