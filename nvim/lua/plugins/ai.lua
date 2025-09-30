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
