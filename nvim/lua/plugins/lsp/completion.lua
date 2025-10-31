return {
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
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*"
    },
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
    { "Kaiser-Yang/blink-cmp-avante" },
  },
  version = "*",
  opts = {
    enabled = function()
      return (vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()) and vim.bo.filetype ~= "DressingInput"
    end,
    fuzzy = {
      implementation = "lua",
      max_typos = function(keyword) return math.floor(#keyword / 4) end,
      frecency = {
        enabled = true,
        unsafe_no_lock = false,
      },
      use_proximity = true,
      sorts = { "score", "sort_text" },
      prebuilt_binaries = { download = false },
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
            return cmp.accept({ callback = function() vim.api.nvim_feedkeys("\n", "n", true) end })
          end,
          "fallback",
        },
      },
      sources = function()
        local type = vim.fn.getcmdtype()

        if type == "/" or type == "?" then return { "buffer" } end
        if type == ":" or type == "@" then return { "cmdline" } end

        return {}
      end,
      completion = {
        trigger = { show_on_blocked_trigger_characters = {} },
        list = { selection = { preselect = false, auto_insert = true } },
        menu = {
          auto_show = true,
          draw = {
            columns = {
              { "label",      "label_description", gap = 1 },
              { "kind_icon" },
              { "kind" },
              { "source_name" },
            },
          },
        },
      },
    },
    term = {
      enabled = false,
      keymap = { preset = "inherit" }, -- Inherits from top level `keymap` config when not set
      -- sources = {},
      completion = {
        trigger = {
          show_on_blocked_trigger_characters = {},
          show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
        },
        list = {
          selection = {
            preselect = nil,   -- When `true`, will automatically select the first item in the completion list
            auto_insert = nil, -- When `true`, inserts the completion item automatically when selecting it
          },
        },
        menu = { auto_show = nil },    -- Whether to automatically show the window when new completion items are available
        ghost_text = { enabled = nil } -- Displays a preview of the selected item on the current line
      }
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
      accept = {
        auto_brackets = {
          enabled = true,
          kind_resolution = {
            enabled = true,
            blocked_filetypes = { "vue" },
          },
          semantic_token_resolution = {
            enabled = true,
            blocked_filetypes = { "java" },
            timeout_ms = 400,
          },
        }
      },
      list = { selection = { preselect = false, auto_insert = true } },
      menu = {
        auto_show = true,
        draw = {
          columns = {
            { "label",      "label_description", gap = 1 },
            { "kind_icon" },
            { "kind" },
            { "source_name" },
          },
          treesitter = { "lsp" },
        },
      },
      documentation = { auto_show = true, auto_show_delay_ms = 500, treesitter_highlighting = true },
      ghost_text = { enabled = false },
    },
    snippets = {
      preset = "luasnip",
      expand = function(snippet)
        require("luasnip").lsp_expand(snippet)
      end,
      active = function(filter)
        if filter and filter.direction then return require("luasnip").jumpable(filter.direction) end

        return require("luasnip").in_snippet()
      end,
      jump = function(direction)
        require("luasnip").jump(direction)
      end,
    },
    sources = {
      -- default = { "lsp", "avante", "snippets", "path", "buffer" },
      default = { "lsp", "snippets", "path", "buffer" },
      providers = {
        cmdline = { min_keyword_length = 0, },
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
          min_keyword_length = 0,
          max_items = 10,
          opts = {
            trailing_slash = false,
            label_trailing_slash = true,
            get_cwd = function(context) return vim.fn.expand(("#%d:p:h"):format(context.bufnr)) end,
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
          enabled = function() return require("cmp_dap").is_dap_buffer() end,
          score_offset = 90,
        },
        markdown = {
          name = "RenderMarkdown",
          enabled = true,
          module = "render-markdown.integ.blink",
          fallbacks = { "lsp" },
        },
        -- avante = {
        --   module = 'blink-cmp-avante',
        --   name = 'Avante',
        --   opts = {}
        -- },
      },
      per_filetype = {
        ["dap-repl"] = { "dap", "path" },
        dapui_watches = { "dap", "path" },
        dapui_hover = { "dap", "path" },
        sql = { "dadbod", "lsp" },
        markdown = { "markdown", "lsp", "buffer", "path" },
        codecompanion = { "codecompanion" },
        -- lua = { inherit_defaults = true, 'lazydev' },
      },
    },
    signature = { enabled = true },
  },
}
