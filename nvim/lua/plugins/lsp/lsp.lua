return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = { { path = "luvit-meta/library", words = { "vim%.uv" } } }, -- load luvit types, when vim.uv is found
      },
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local textDocument = { completion = { completionItem = { snippetSupport = false } } }
    local workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }
    local offsetEncoding = { "utf-16" }
    local general = { positionEncodings = { "utf-16" } }

    -- local capabilities = cmp_nvim_lsp.default_capabilities({
    --   workspace,
    --   offsetEncoding,
    --   general,
    -- })

    local capabilities = require("blink.cmp").get_lsp_capabilities({
      workspace,
      offsetEncoding,
      general,
    })

    -- LSP Servers

    -- Lua LSP: install lua lsp server; official installation guide for sumneko_l
    lspconfig.lua_ls.setup({
      capabilitie = capabilities,
      settings = { Lua = { telemetry = { enable = false } } },
    })

    -- Typescript LSP: install typescript LSP (ts_ls) npm install -g typescript typescript-language-server
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = os.getenv("HOME") .. "/.nvm/versions/node/v22.9.0/lib/node_modules/@vue/language-server/",
            languages = { "vue" },
          },
        },
      },
      filetypes = { "javascript", "typescript", "vue" },
    })

    -- Vue3 LSP
    lspconfig.volar.setup({})

    -- C/C++ LSP: install c/c++ LSP (clangd) apt install clangd
    lspconfig.clangd.setup({
      cmd = { "clangd", "-completion-style=detailed" },
      offset_encoding = "utf-16",
      capabilities = capabilities,
    })

    lspconfig.cmake.setup({ capabilities = capabilities })

    -- JSON LSP: install json LSP npm install -g vscode-langservers-extracted
    lspconfig.jsonls.setup({ capabilities = capabilities })

    lspconfig.cssls.setup({ capabilities = capabilities })

    -- HTML LSP: seems not to be useful
    lspconfig.html.setup({ capabilities = capabilities })

    -- Python LSP
    lspconfig.pyright.setup({
      root_dir = function(fname)
        local util = require("lspconfig.util")
        return util.root_pattern("pyproject.toml", "requirements.txt", "pyrightconfig.json", ".git")(fname)
      end,
      capabilities = capabilities,
      flags = { debounce_text_changes = 500 },
      settings = {
        python = {
          analysis = {
            diagnosticMode = "openFilesOnly",
            typeCheckingMode = "basic",
            useLibraryCodeForTypes = false,
            autoSearchPaths = false,
          },
        },
      },
    })

    -- lspconfig.basedpyright.setup({ capabilities = capabilities })

    -- Bash LSP npm install -g bash-language-server; install spellcheck: apt install spellcheck
    lspconfig.bashls.setup({ capabilities = capabilities })

    -- npm install -g emmet-ls
    lspconfig.emmet_ls.setup({ capabilities = capabilities })

    -- Docker-Compose LSP: npm install -g @microsoft/compose-language-service
    lspconfig.docker_compose_language_service.setup({ filetypes = { "yaml.docker-compose" } })

    -- Dockerfile LSP: npm install -g dockerfile-language-server-nodejs
    lspconfig.dockerls.setup({})

    -- YAML LSP: npm install -g yaml-language-server
    lspconfig.yamlls.setup({
      filetypes = { "yaml" },
      settings = {
        yaml = { keyOrdering = false },
        redhat = { telemetry = { enabled = false } },
      },
    })

    for type, icon in pairs({ Error = "", Warn = "", Hint = "", Info = " " }) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local keymap = vim.keymap
    keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definitions" })
    keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration " })
    keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
    keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementations" })

    keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "See available code actions" })
    keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, { desc = "Show signature" })
    keymap.set("n", "gh", vim.lsp.buf.hover)
    keymap.set("n", "gp", vim.diagnostic.goto_prev)
    keymap.set("n", "gn", vim.diagnostic.goto_next)

    keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "Smart Rename" })

    keymap.set("n", "go", vim.lsp.buf.outgoing_calls, { desc = "Show outgoing calls" })
    keymap.set("n", "gi", vim.lsp.buf.incoming_calls, { desc = "Show incoming calls" })

    keymap.set("n", "gf", vim.diagnostic.open_float)
  end,
}
