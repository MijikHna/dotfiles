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

    require("treesitter-context").setup()

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        vim.treesitter.start()

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
