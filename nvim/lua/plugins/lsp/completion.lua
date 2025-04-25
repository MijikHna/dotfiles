return {
  {
    "saghen/blink.cmp",
    enabled = true,
    event = "VeryLazy",
    dependencies = {
      {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
      },
      "onsails/lspkind.nvim",
      { "L3MON4D3/LuaSnip", version = "v2.*" },
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
          require("luasnip.loaders.from_vscode").lazy_load({
            paths = { vim.fn.stdpath("config") .. "/nvim/my-snippets" },
          })
        end,
      },
      { "rcarriga/cmp-dap" },
      { "kristijanhusak/vim-dadbod-completion" },
    },
    version = "*",
    opts = {
      enabled = function()
        return (vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()) and vim.bo.filetype ~= "DressingInput"
      end,
      fuzzy = {
        max_typos = function(keyword)
          return math.floor(#keyword / 4)
        end,
        use_frecency = true,
        use_proximity = true,
        use_unsafe_no_lock = false,
        sorts = { "score", "sort_text" },
        prebuilt_binaries = { download = true },
      },
      keymap = {
        preset = "default",
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<S-k>"] = { "scroll_documentation_up", "fallback" },
        ["<S-j>"] = { "scroll_documentation_down", "fallback" },

        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
      },
      cmdline = {
        enabled = true,
        keymap = {
          preset = "enter",
          ["<CR>"] = {
            function(cmp)
              return cmp.accept({
                callback = function()
                  vim.api.nvim_feedkeys("\n", "n", true)
                end,
              })
            end,
            "fallback",
          },
        },
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end

          if type == ":" or type == "@" then
            return { "cmdline" }
          end
          return {}
        end,
        completion = {
          trigger = { show_on_blocked_trigger_characters = {} },
          list = { selection = { preselect = false, auto_insert = true } },
          menu = {
            auto_show = true,
            draw = {
              columns = {
                { "label", "label_description", gap = 1 },
                { "kind_icon" },
                { "kind" },
                { "source_name" },
              },
            },
          },
        },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        trigger = {
          show_on_keyword = true,
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
          show_on_accept_on_trigger_character = true,
        },
        keyword = { range = "full" },
        accept = { auto_brackets = { enabled = true } },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon" },
              { "kind" },
              { "source_name" },
            },
            treesitter = { "lsp" },
          },
        },
        documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = false },
        ghost_text = { enabled = false },
      },
      snippets = {
        preset = "luasnip",
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        providers = {
          cmdline = {
            min_keyword_length = 0,
          },
          lsp = {
            name = "LSP",
            module = "blink.cmp.sources.lsp",
            enabled = true,
            max_items = 15,
            min_keyword_length = 0,
            score_offset = 90,
          },
          path = {
            name = "Path",
            module = "blink.cmp.sources.path",
            enabled = true,
            score_offset = 25,
            fallbacks = { "buffer" },
            min_keyword_length = 2,
            max_items = 10,
            opts = {
              trailing_slash = false,
              label_trailing_slash = true,
              get_cwd = function(context)
                return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
              end,
              show_hidden_files_by_default = true,
            },
          },
          buffer = {
            name = "Buffer",
            module = "blink.cmp.sources.buffer",
            enabled = true,
            max_items = 10,
            min_keyword_length = 2,
            score_offset = 30,
          },
          snippets = {
            name = "snippets",
            opts = {
              use_show_condition = true,
              show_autosnippets = true,
            },
            module = "blink.cmp.sources.snippets",
            enabled = true,
            max_items = 10,
            min_keyword_length = 2,
            score_offset = 50,
          },
          dadbod = {
            name = "Dadbod",
            enabled = true,
            module = "vim_dadbod_completion.blink",
            min_keyword_length = 2,
            score_offset = 85, -- the higher the number, the higher the priority
          },
          dap = {
            name = "dap",
            module = "blink.compat.source",
            enabled = function()
              return require("cmp_dap").is_dap_buffer()
            end,
            score_offset = 90,
          },
          markdown = {
            name = "RenderMarkdown",
            enabled = true,
            module = "render-markdown.integ.blink",
            fallbacks = { "lsp" },
          },
        },
        per_filetype = {
          ["dap-repl"] = { "dap", "path" },
          dapui_watches = { "dap", "path" },
          dapui_hover = { "dap", "path" },
          sql = { "dadbod", "lsp" },
          markdown = { "markdown", "lsp", "buffer", "path" },
        },
      },
      signature = { enabled = true },
    },
  },
  {
    "hrsh7th/cmp-cmdline",
    enabled = false,
    config = function()
      local cmp = require("cmp")

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    enabled = false,
    dependencies = {
      "hrsh7th/cmp-buffer", -- source for text in buffer
      "hrsh7th/cmp-path", -- source for file system paths
      "hrsh7th/cmp-cmdline",
      "rcarriga/cmp-dap",
      "onsails/lspkind.nvim", -- vs-code like pictograms
      { "kristijanhusak/vim-dadbod-completion", lazy = true },
      { "L3MON4D3/LuaSnip", version = "2.*" },
      "saadparwaiz1/cmp_luasnip", -- for autocompletion
      "rafamadriz/friendly-snippets", -- useful snippets
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        window = {
          documentation = {
            -- winblend = 50,
            winhighlight = "Normal:Pmenu",
          },
        },
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = { -- configure how nvim-cmp interacts with snippet engine
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<C-n>"] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
          ["<C-p>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end,
        }),
        -- sources for autocompletion
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- snippets
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
          { name = "lazydev", group_index = 0 }, -- skip loading LuaLS completions
          { name = "cmp-cmdline" },
        }),

        -- configure lspkind for vs-code like pictograms in completion menu
        formatting = {
          format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },
        enabled = function()
          return vim.api.nvim_get_option_info2("buftype", {}) ~= "prompt" or require("cmp_dap").is_dap_buffer()
        end,
      })

      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, { sources = { { name = "dap" } } })
      cmp.setup.filetype({ "sql" }, { sources = { { name = "vim-dadbod-completion" }, { name = "buffer" } } })
      cmp.setup.filetype({ "markdown" }, { sources = { { name = "render-markdown" }, { name = "buffer" } } })

      -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip/loaders/from_vscode").lazy_load({ paths = "~/.config/nvim/my-snippets" })

      local keymap = vim.keymap

      keymap.set(
        "i",
        "<Tab>",
        "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'",
        { expr = true, silent = true }
      )
      keymap.set("s", "<Tab>", function()
        luasnip.jump(1)
      end, { silent = true })
      keymap.set("s", "<S-Tab>", function()
        luasnip.jump(-1)
      end, { silent = true })
      keymap.set(
        "i",
        "<C-E>",
        "luasnip#choise_active() ? '<Plug>luasnip-next-choice' : '<C-E>'",
        { expr = true, silent = true }
      )
    end,
  },
}
