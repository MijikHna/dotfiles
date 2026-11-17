local selected_model = {
  model = "nvidia/nemotron-3-nano-omni-30b-a3b-reasoning:free",
  provider = "nvidia"
}

local get_open_router_api_key = function()
  local key_path = vim.fn.expand("~/secrets/openrouter")
  local file = io.open(key_path, "r")

  if file then
    local key = vim.trim(file:read("*a"))
    vim.env.OPENROUTER_API_KEY = key
    file:close()

    return key
  else
    vim.notify("OpenRouter API key file not found at: " .. key_path, vim.log.levels.WARN)
  end
end

get_open_router_api_key()

return {
  {
    "yetone/avante.nvim",
    build = "make",
    enabled = true,
    event = "VeryLazy",
    version = false,
    opts = {
      instructions_file = "avante.md",
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = selected_model.model,
          timeout = 30000,
          extra_request_body = {
            max_tokens = nil,
            sync = true,
            allow_fallbacks = false,
            require_parameters = false,
            data_collection = false,
          },
        },
      },
      behavior = {
        auto_suggestions = false,
        auto_scroll = true,
        auto_scroll_delay = 100,
        auto_scroll_threshold = 0.9,
        auto_scroll_speed = 1,
        show_token_usage = true,
        auto_approve_tool_permissions = false,
        auto_add_current_file = false,
        auto_apply_diff_after_generation = false,
      },
      windows = {
        position = "right",
        -- wrap = true,
        width = 40,
      },
      history = {
        enabled = true,
        auto_save = true,
        expiration_days = 30,
        dir_to_save = vim.fn.stdpath("data") .. "/avante-history",
      },
      web_search_enginge = nil,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      { "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
      "nvim-mini/mini.pick",           -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua",              -- for file_selector provider fzf
      "folke/snacks.nvim",             -- for input provider snacks
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = {
            "markdown",
            "markdown.Avante" -- until a fix for https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/715 is found
          },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    -- version = "v17.33.0",
    enabled = true,
    dependencies = {
      "github/copilot.vim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim"
    },
    opts = {
      strategies = {
        chat = {
          adapter = {
            name = "openrouter",
            model = selected_model.model,
            provider = selected_model.provider,
            max_tokens = nil,
          }
        },
        inline = {
          adapter = {
            name = "openrouter",
            model = selected_model,
            provider = selected_model.provider
          }
        },
        cmd = {
          adapter = {
            name = "openrouter",
            model = selected_model,
            provider = selected_model.provider,
          }
        },
        keymaps = { clear = { modes = { n = "gC" } } }
      },
      collapse_tools = false,
      adapters = {
        http = {
          openrouter = function()
            return require("codecompanion.adapters").extend("openrouter", {
              env = {
                api_key = "file:~/secrets/openrouter",
                -- url = "http://salvatore:8080"
              },
              headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer ${api_key}",
              },
              parameters = { sync = true },
              schema = {
                model = {
                  default = selected_model,
                  -- choices = function() return fetch_openrouter_models() end,
                },
                provider = {
                  allow_fallbacks = false,
                  require_parameters = false,
                  data_collection = false,
                },
              },
            })
          end,
          opts = {
            show_model_choices = true,
          },
        },
      },
      interactions = {
        chat = { adapter = { name = "openrouter" } },
        inline = { adapter = { name = "openrouter" } },
        cmd = { adapter = { name = "openrouter" } },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",
            save_chat_keymap = "<leader>ccs",
            auto_save = true,
            expiration_days = 30,
            picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
            chat_filter = nil,    -- function(chat_data) return boolean end
            picker_keymaps = {
              rename = { n = "r", i = "<M-r>" },
              delete = { n = "d", i = "<M-d>" },
              duplicate = { n = "<C-y>", i = "<C-y>" },
            },
            auto_generate_title = true,
            title_generation_opts = {
              adapter = "copilot",         ---Adapter for generating titles (defaults to current chat adapter); "copilot"
              model = nil,                 -- Model for generating titles (defaults to current chat model);"gpt-4o"
              refresh_every_n_prompts = 0, ---Number of user prompts after which to refresh the title (0 to disable); e.g., 3 to refresh after every 3rd user prompt
              max_refreshes = 3,           ---Maximum number of times to refresh the title (default: 3)
              format_title = function(original_title) return original_title end
            },
            continue_last_chat = true,
            delete_on_clearing_chat = false,
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history", -- ~/.local/share/nvim
            enable_logging = false,
          }
        }
      },
      display = {
        chat = {
          show_settings = false
        }
      }
    },
    init = function()
      local keymap = vim.keymap

      keymap.set(
        { "n", "v" }, "<leader>cct", "<cmd>CodeCompanionChat Toggle<CR>|:wincmd =<CR>",
        { desc = "[C]ode[C]ompanion [T]oggle" }
      )
      keymap.set(
        { "n", "v" }, "<leader>cca", "<cmd>CodeCompanionChat Add<CR>",
        { desc = "[C]ode[C]ompanion [A]dd Selection" }
      )
      keymap.set(
        { "n", "v" }, "<leader>cci", "<cmd>CodeCompanion<CR>",
        { desc = "[C]ode[C]ompanion [I]nline Assistant" }
      )
      keymap.set(
        { "n", "v" }, "<leader>ccm", "<cmd>CodeCompanionActions<CR>",
        { desc = "[C]ode[C]ompanion Action [M]enu" }
      )
      keymap.set(
        { "n", "v" }, "<leader>cch", "<cmd>CodeCompanionHistory<CR>",
        { desc = "[C]ode[C]ompanion [H]istory" }
      )
    end
  },
}
