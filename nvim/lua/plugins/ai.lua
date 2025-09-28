return {
  {
    "github/copilot.vim",
    enabled = true,
    config = function()
      local keymap = vim.keymap

      keymap.set("i", "<C-Q>", "copilot#Accept('\\<CR>')", { expr = true, replace_keycodes = false })

      keymap.set("i", "<C-F>", "<Plug>(copilot-accept-word)")
      keymap.set("i", "<C-G>", "<Plug>(copilot-accept-line)")

      vim.g.copilot_filetypes = { markdown = true, DressingInput = false }
      vim.g.copilot_no_tab_map = true

      vim.cmd("Copilot disable")
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    build = "make",
    opts = {
      instructions_file = "avante.md",
      provider = "copilot",
      providers = {
        copilot = {
          endpoint = "https://api.githubcopilot.com",
          model = "gpt-4o-2024-05-13",
          proxy = nil,            -- [protocol://]host[:port] Use this proxy
          allow_insecure = false, -- Allow insecure server connections
          timeout = 30000,        -- Timeout in milliseconds
          extra_request_body = {
            max_tokens = 8192,
            temperature = 0,
          }
        }
      },

      file_selector = {
        provider = "telescope",
        provider_opts = {},
      },
      selector = {
        provider = "native",
        provider_opts = {},
      },
      input = {
        provider = "dressing",
        provider_opts = {},
      },
      shortcuts = {
        {
          name = "refactor",
          description = "Refactor code with best practices",
          details =
          "Automatically refactor code to improve readability, maintainability, and follow best practices while preserving functionality",
          prompt =
          "Please refactor this code following best practices, improving readability and maintainability while preserving functionality."
        },
        {
          name = "test",
          description = "Generate unit tests",
          details = "Create comprehensive unit tests covering edge cases, error scenarios, and various input conditions",
          prompt = "Please generate comprehensive unit tests for this code, covering edge cases and error scenarios."
        },
        -- Add more custom shortcuts...
      },
      mappings = { sidebar = { close = { "q" } } },
      windows = {
        edit = { start_insert = true, },
        ask = { start_insert = true },
      },
      behaviour = { enable_fastapply = true },
      web_search_engine = {
        provider = "tavily", -- tavily, serpapi, google, kagi, brave, or searxng
        proxy = nil,         -- proxy support, e.g., http://127.0.0.1:7890
      }
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "stevearc/dressing.nvim",
      "folke/snacks.nvim",             -- for input provider snacks
      "nvim-tree/nvim-web-devicons",
      "github/copilot.vim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
      },

    },
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = true,
    dependencies = {
      -- "github/copilot.vim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim"
    },
    opts = {
      strategies = {
        chat = { adapter = "copilot" },
        inline = { adapter = "copilot" },
        cmd = { adapter = "copilot" }
      },
      collapse_tools = false,
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "<leader>ccs",
            auto_save = false,
            expiration_days = 15,
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
            chat_filter = nil,    -- function(chat_data) return boolean end
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            auto_generate_title = false,
            title_generation_opts = {
              adapter = nil,               ---Adapter for generating titles (defaults to current chat adapter); "copilot"
              model = nil,                 -- Model for generating titles (defaults to current chat model);"gpt-4o"
              refresh_every_n_prompts = 0, ---Number of user prompts after which to refresh the title (0 to disable); e.g., 3 to refresh after every 3rd user prompt
              max_refreshes = 3,           ---Maximum number of times to refresh the title (default: 3)
              format_title = function(original_title)
                return original_title      -- this can be a custom function that applies some custom, formatting to the title.
              end
            },
            continue_last_chat = true,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            enable_logging = false,
          }
        }
      },
    },
    init = function()
      local keymap = vim.keymap

      keymap.set({ "n", "v" }, "<leader>cct", "<cmd>CodeCompanionChat Toggle<CR>",
        { desc = "[C]ode[C]ompanion [T]oggle" })
      keymap.set({ "n", "v" }, "<leader>cca", "<cmd>CodeCompanionChat Add<CR>",
        { desc = "[C]ode[C]ompanion [A]dd Selection" })
      keymap.set({ "n", "v" }, "<leader>cci", "<cmd>CodeCompanion<CR>", { desc = "[C]ode[C]ompanion [I]nline Assistant" })
      keymap.set({ "n", "v" }, "<leader>ccm", "<cmd>CodeCompanionActions<CR>",
        { desc = "[C]ode[C]ompanion Action [M]enu" })
      keymap.set({ "n", "v" }, "<leader>cch", "<cmd>CodeCompanionHistory<CR>", { desc = "[C]ode[C]ompanion [H]istory" })
    end
  },
}
