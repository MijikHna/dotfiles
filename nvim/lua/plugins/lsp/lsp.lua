return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "saghen/blink.cmp",
    { "antosha417/nvim-lsp-file-operations", config = true, enabled = false },
    {
      "folke/lazydev.nvim",
      ft = "lua",                                                                      -- only load on lua files
      opts = { library = { { path = "luvit-meta/library", words = { "vim%.uv" } } } }, -- load luvit types, when vim.uv is found
    },
  },

  config = function ()
    local lspconfig = require("lspconfig")
    -- local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local arduino_util = require("utils.arduino")
    local qt = require("utils.qt")

    local textDocument = {
      completion = { completionItem = { snippetSupport = false } },
      foldingRange = { dynamicRegistration = false, lineFoldingOnly = true }
    }
    local workspace = { didChangeWatchedFiles = { dynamicRegistration = true } }
    local offsetEncoding = { "utf-16" }
    local general = { positionEncodings = { "utf-16" } }

    -- local capabilities = cmp_nvim_lsp.default_capabilities({
    --   workspace,
    --   offsetEncoding,
    --   general,
    -- })

    local capabilities = require("blink.cmp").get_lsp_capabilities({
      workspace = workspace,
      offsetEncoding = offsetEncoding,
      general = general,
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

    --[[  Java LSP:
      1: clone repository git clone https://github.com/eclipse/eclipse.jdt.ls.git,
      2: mvn clean verify -DskipTests=true
      3: set JDTLS_HOME to .../eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository
    ]]
    --
    lspconfig.jdtls.setup({ capabilities = capabilities })

    lspconfig.cmake.setup({ capabilities = capabilities })

    -- JSON LSP: install json LSP npm install -g vscode-langservers-extracted
    lspconfig.jsonls.setup({ capabilities = capabilities })

    lspconfig.cssls.setup({ capabilities = capabilities })

    -- HTML LSP: seems not to be useful
    lspconfig.html.setup({ capabilities = capabilities })

    -- Python LSP
    lspconfig.pyright.setup({ capabilities = capabilities })
    -- lspconfig.basedpyright.setup({ capabilities = capabilities })

    -- Bash LSP npm install -g bash-language-server; install spellcheck: apt install spellcheck
    lspconfig.bashls.setup({ capabilities = capabilities })

    -- npm install -g emmet-ls
    lspconfig.emmet_ls.setup({ capabilities = capabilities })

    -- Docker-Compose LSP: npm install -g @microsoft/compose-language-service
    lspconfig.docker_compose_language_service.setup({
      capabilities = capabilities,
      filetypes = { "yaml.docker-compose" },
    })

    -- Dockerfile LSP: npm install -g dockerfile-language-server-nodejs
    lspconfig.dockerls.setup({ capabilities = capabilities })

    -- YAML LSP: npm install -g yaml-language-server
    lspconfig.yamlls.setup({
      capabilities = capabilities,
      filetypes = { "yaml" },
      settings = {
        yaml = { keyOrdering = false },
        redhat = { telemetry = { enabled = false } },
      },
    })

    -- Arduino LSP: go install github.com/arduino/arduino-language-server@latest; install arduino-cli
    -- local fqbn = "esp8266:esp8266:d1_mini_pro"
    lspconfig.arduino_language_server.setup({
      -- general = { positionEncodings = { "utf-16" } },
      -- capabilities = capabilities,
      cmd = {
        "arduino-language-server",
        "-clangd",
        "/usr/bin/clangd",
        "-cli",
        os.getenv("HOME") .. "/prog/arduino/arduino-cli/bin/arduino-cli",
        "-cli-config",
        os.getenv("HOME") .. "/.arduino15/arduino-cli.yml",
        "-fqbn",
        arduino_util.get_arduino_board_fqbn(),
      },
    })

    -- Rust LSP
    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      settings = { ["rust-analyzer"] = { diagnostics = { enable = true } } },
    })

    lspconfig.qmlls.setup({ capabilities = capabilities, cmd = { qt.get_qmlls_path() } })

    lspconfig.texlab.setup({ capabilities = capabilities })

    -- for type, icon in pairs({ Error = "", Warn = "", Hint = "", Info = " " }) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    -- end

    vim.diagnostic.config({
      severity_sort = true,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "",
          [vim.diagnostic.severity.INFO] = "",
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = "ErrorMsg",
          [vim.diagnostic.severity.WARN] = "WarningMsg",
          [vim.diagnostic.severity.HINT] = "HintMsg",
          [vim.diagnostic.severity.INFO] = "InfoMsg",
        },
      },
      virtual_text = true,
      virtual_lines = false,
      underline = { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } },
    })

    local keymap = vim.keymap

    keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]o to [D]efinitions" })
    keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]o to [[D]]eclaration " })
    keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]o to [R]eferences" })
    keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "[G]o to [[I]]mplementations" })

    keymap.set({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "[G]o to Code [A]ctions" })
    keymap.set({ "n", "i" }, "<C-h>", vim.lsp.buf.signature_help, { desc = "Signature" })
    keymap.set("n", "gs", vim.lsp.buf.signature_help, { desc = "[G]o how [S]ignature" })
    keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "[H]over" })
    keymap.set("n", "gp", function ()
      vim.diagnostic.jump({ count = -1 })
    end, { desc = "[G]o to [P]revious Diagnostics" })
    keymap.set("n", "gn", function ()
      vim.diagnostic.jump({ count = 1 })
    end, { desc = "[G]o to [N]ext Diagnostics" })

    keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "[G]o to [R]ename" })

    keymap.set("n", "go", vim.lsp.buf.outgoing_calls, { desc = "[G]o [O]utgoing Calls" })
    keymap.set("n", "gi", vim.lsp.buf.incoming_calls, { desc = "[G]o [I]ncoling Calls" })

    keymap.set("n", "gf", vim.diagnostic.open_float, { desc = "[G]o to [F]loat Window Diagnostics" })

    vim.keymap.set("n", "gv", function ()
      vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })

      vim.api.nvim_create_autocmd("CursorMoved", {
        group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
        callback = function ()
          vim.diagnostic.config({ virtual_lines = false, virtual_text = true })
          return true
        end,
      })
    end, { desc = " [G]o to [V]irtual Lines" })
  end,
}
