return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "cmake",
        "cpp",
        "dockerfile",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "ninja",
        "python",
        "qmldir",
        "qmljs",
        "regex",
        "scss",
        "todotxt",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
      sync_install = false,
      ignore_install = { "all" },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enanble = true },
      autotag = {
        enable = true,
      },
      interactive_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = false,
          node_decremental = "grm",
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })

    require("treesitter-context").setup()

    local opt = vim.opt

    opt.foldmethod = "expr"
    opt.foldexpr = "nvim_treesitter#foldexpr()"

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.hbs",
      command = "set filetype=html",
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.tcss",
      command = "set filetype=css",
    })
  end,
}
