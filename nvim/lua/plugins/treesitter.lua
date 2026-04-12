return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
  },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  enabled = true,
  config = function()
    local ensure_installed = {
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
      "latex",
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
    }
    require('nvim-treesitter').install(ensure_installed)

    -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    -- parser_config.latex = {
    --   install_info = {
    --     url = os.getenv("HOME") .. "/prog/tree-sitter/tree-sitter-latex",
    --     files = { "src/parser.c", "src/scanner.c" },
    --   },
    -- }

    -- require("nvim-treesitter.configs").setup({
    --   sync_install = false,
    --   ignore_install = { "all" },
    --   highlight = {
    --     enable = true,
    --     additional_vim_regex_highlighting = false,
    --   },
    --   indent = { enanble = true },
    --   autotag = {
    --     enable = true,
    --   },
    --   interactive_selection = {
    --     enable = true,
    --     keymaps = {
    --       init_selection = "gnn",
    --       node_incremental = "grn",
    --       scope_incremental = false,
    --       node_decremental = "grm",
    --     },
    --   },
    --   playground = {
    --     enable = true,
    --     disable = {},
    --     updatetime = 25,         -- Debounced time for highlighting nodes in the playground from source code
    --     persist_queries = false, -- Whether the query persists across vim sessions
    --     keybindings = {
    --       toggle_query_editor = "o",
    --       toggle_hl_groups = "i",
    --       toggle_injected_languages = "t",
    --       toggle_anonymous_nodes = "a",
    --       toggle_language_display = "I",
    --       focus_language = "f",
    --       unfocus_language = "F",
    --       update = "R",
    --       goto_node = "<cr>",
    --       show_help = "?",
    --     },
    --   },
    -- })

    require("treesitter-context").setup()

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()
        vim.print("FileType")

        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
      end,
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.hbs",
      command = "set filetype=html",
    })

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.tcss",
      command = "set filetype=css",
    })

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
      callback = function()
        local closed_folds = {}

        for line_num = 1, vim.fn.line('$') do
          if vim.fn.foldclosed(line_num) == line_num then
            table.insert(closed_folds, line_num)
          end
        end

        vim.cmd("normal! zx")

        for _, lnum in ipairs(closed_folds) do
          vim.cmd(lnum .. "foldclose")
        end
      end,
    })
  end,
}
