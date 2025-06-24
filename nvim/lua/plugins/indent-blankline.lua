return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  config = function ()
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")

    local highlight = { "RainbowBlue" }

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    end)

    ibl.setup({
      -- indent = { char = "|" },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = highlight,
        include = {
          node_type = {
            lua = {
              "chunk",
              "do_statement",
              "while_statement",
              "repeat_statement",
              "if_statement",
              "for_statement",
              "function_declaration",
              "function_definition",
              "table_constructor",
              "assignment_statement",
            },
            typescript = {
              "statement_block",
              "function",
              "arrow_function",
              "function_declaration",
              "method_definition",
              "for_statement",
              "for_in_statement",
              "catch_clause",
              "object_pattern",
              "arguments",
              "switch_case",
              "switch_statement",
              "switch_default",
              "object",
              "object_type",
              "ternary_expression",
            },
            python = {
              "arguments",
              "arrow_function",
              "assignment_statement",
              "catch_clause",
              "chunk",
              "do_statement",
              "for_in_statement",
              "for_statement",
              "function",
              "function_declaration",
              "function_definition",
              "if_statement",
              "method_definition",
              "object",
              "object_pattern",
              "object_type",
              "repeat_statement",
              "statement_block",
              "switch_case",
              "switch_default",
              "switch_statement",
              "ternary_expression",
              "while_statement",
            }
          },
        },
      },
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "txt",
          "dashobard",
          "lspinfo",
        },
      },
    })

    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    local opt = vim.opt

    opt.list = true
    opt.listchars = { eol = "↴", tab = ":>-", }
  end,
}
