return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      DONE = { icon = "✔ ", color = "info", alt = { "COMPLETE", "FINISH" } },
      TRASH = { icon = " ", color = "info", alt = { "DELETE", "REMOVE", "DISP", "DISPENSABLE" } },
      WHY = { icon = " ", color = "warning", alt = { "HELP", "QUESTION", "THINK-ABOUT-IT" } },
    },
  },
}
