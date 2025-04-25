return {
  {
    "github/copilot.vim",
    enabled = true,
    event = "VeryLazy",
    init = function()
      vim.g.copilot_filetypes = { markdown = true, DressingInput = false }
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.cmd("Copilot disable")

      local keymap = vim.keymap

      keymap.set("i", "<C-Q>", "copilot#Accept('\\<CR>')", { expr = true, replace_keycodes = false })
      keymap.set("i", "<C-L>", "<Plug>(copilot-accept-word)")
      keymap.set("i", "<C-J>", "<Plug>(copilot-accept-line)")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    event = "VeryLazy",
    enabled = true,
    branch = "main",
    dependencies = {
      "github/copilot.vim",
    },
    opts = {},
    init = function()
      vim.keymap.set("n", "<leader>cct", ":CopilotChatToggle<CR><C-w>=")
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    -- dev = true,
    -- dir = os.getenv("CODING") .. "/Projects/Nvim Plugins/avante.nvim",
    event = "VeryLazy",
    build = "make",
    opts = {
      provider = "copilot",
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "gpt-4o-2024-05-13",
        proxy = nil, -- [protocol://]host[:port] Use this proxy
        allow_insecure = false, -- Allow insecure server connections
        timeout = 30000, -- Timeout in milliseconds
        temperature = 0,
        max_tokens = 8192,
      },
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "robitx/gp.nvim",
    enabled = true,
    event = "VeryLazy",
    config = function()
      local conf = {
        providers = {
          copilot = {
            endpoint = "https://api.githubcopilot.com/chat/completions",
            secret = {
              "bash",
              "-c",
              "cat ~/.config/github-copilot/apps.json | sed -e 's/.*oauth_token...//;s/\".*//'",
            },
          },
        },
        agents = {
          {
            provider = "copilot",
            name = "ChatCopilot",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o", temperature = 1.0, top_p = 1, n = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "Response must be short. Response must be casual. Response can have opinion. Response don't contain code, if not explicitly asked for code.",
          },
        },
        hooks = {
          Translator = function(gp, params)
            local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
            gp.cmd.ChatNew(params, chat_system_prompt)
          end,
          -- example of adding command which writes unit tests for the selected code
          UnitTests = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by writing table driven unit tests for the code above."
            local agent = gp.get_command_agent()
            gp.Prompt(params, gp.Target.enew, agent, template)
          end,
          -- example of adding command which explains the selected code
          Explain = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please respond by explaining the code above."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.popup, agent, template)
          end,
          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
          end,
          -- TODO: grab a selection find Diagnostics in there and ask the question providing better context
          FixDiagnostics = function(gp, params)
            print()
            local current_cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1
            local lsp_diagnostics_errors = vim.diagnostic.get(0, { lnum = current_cursor_line })

            if #lsp_diagnostics_errors > 0 then
              local lsp_diagnostics_message = ""
              for _, lsp_diagnostics_error in ipairs(lsp_diagnostics_errors) do
                lsp_diagnostics_message = lsp_diagnostics_error.message
                if lsp_diagnostics_error.severity == 1 then
                  break
                end
              end
              local template = "Please explain and fix following error: `"
                .. lsp_diagnostics_message
                .. "`"
                .. " in following code\n\n"
                .. "```{{filetype}}\n{{selection}}```"
                .. "Please also print out thsi question."
              local agent = gp.get_chat_agent()
              print(template)
              gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
            else
              print("No diagnostics on this line.")
            end
          end,
        },
      }

      require("gp").setup(conf)
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = { copilot = "copilot" },
    },
  },
}
