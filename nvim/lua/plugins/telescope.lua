return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function ()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "filename_first" },
          file_ignore_patterns = {
            "node_modules/",
            "dist/",
            ".venv/",
            ".env",
            "plugged/",
            "undodir/",
            "%.git/",
            "build/",
            ".cache",
            "bin/",
            "target/",
            "lib/",
            "vcpkg_installed/",
            ".nuxt/",
            "%.jpg",
            "%.png",
            "%.pdf",
            "%.fls",
            "%.aux",
            "package%-lock.json",
          },
          mappings = {
            i = {
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          layout_strategy = "center",
          layout_config = { height = 0.35, width = 0.55 }, --center
          prompt_position = "bottom",
        },
        pickers = {
          find_files = {
            hidden = true,
            -- no_ignore = true,
            file_ignore_patterns = {
              "node_modules/",
              "dist/",
              ".venv/",
              "plugged/",
              "undodir/",
              "%.git/",
              "build/",
              ".cache",
              "bin/",
              "target/",
              "lib/",
              "vcpkg_installed/",
              ".nuxt/",
            },
          },
        },
        extensions = {
          live_grep_args = {
            auto_quoting = false,
            mappings = { -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
              },
            },
          },
          fzf = {
            fuzzy = false,                  -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
          },
        },
      })

      telescope.load_extension("live_grep_args")
      require("telescope").load_extension("notify")

      -- local previewers = require("telescope.previewers")
      -- local Job = require("plenary.job")
      --
      -- require("telescope.builtin").find_files({
      --   previewer = previewers.new_buffer_previewer({
      --     define_preview = function(self, entry, status)
      --       Job
      --         :new({
      --           command = "cat",
      --           args = { entry.path },
      --           on_exit = function(j)
      --             local lines = j:result()
      --             vim.schedule(function()
      --               vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      --               vim.api.nvim_buf_set_option(self.state.bufnr, "filetype", "env") -- optional
      --               vim.api.nvim_buf_set_option(self.state.bufnr, "conceallevel", 2)
      --
      --               vim.cmd(string.format("syntax match EnvVarValue /\\(^[^=]*=\\)\\@<=.*/ conceal cchar=🔒"))
      --               vim.cmd("highlight link EnvVarValue Conceal")
      --             end)
      --           end,
      --         })
      --         :start()
      --     end,
      --   }),
      -- })

      local keymap = vim.keymap
      keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "[F]ind Files" })
      keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "[F]ind [H]elp Tags" })
      keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "[B]uffers" })
      keymap.set("n", "<leader>fB", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Current [B]uffer Fuzzy" })

      keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "[F]ind [G]rep Live" })
      keymap.set("n", "<leader>fa", ":Telescope live_grep_args<CR>", { desc = "[F]ind Grep Live [A]rgs" })

      keymap.set("n", "<leader>fs", ":Telescope grep_string<CR>", { desc = "[F]ind Grep [S]tring" })

      keymap.set("n", "<leader>fd", ":Telescope lsp_definitions<CR>", { desc = "[F]ind LSP [D]efinitions" })
      keymap.set("n", "<leader>fD", ":Telescope lsp_type_definitions", { desc = "[Find ]Go to [[D]]eclaration " })
      keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { desc = "[F]ind LSP [R]eferences" })
      keymap.set("n", "<leader>fI", "Telescope lsp_implementations<CR>", { desc = "[F]ind [I]mplementations" })
      keymap.set("n", "<leader>fo", ":Telescope lsp_outgoing_calls<CR>", { desc = "[F]ind [O]utgoing calls" })
      keymap.set("n", "<leader>fi", ":Telescope lsp_incoming_calls<CR>", { desc = "[F]ind [I]ncoming calls" })

      keymap.set("n", "<leader>vq", ":Telescope quickfix<CR>", { desc = "[V]iew [Q]ickfix Actions" })
      keymap.set("n", "<leader>vt", ":Telescope diagnostics bufnr=0<CR>", { desc = "[V]iew D[T]iagnostics" })

      keymap.set("n", "<leader>ft", ":Telescope treesitter<CR>", { desc = "[F]ind in [T]reesitter" })
      keymap.set("n", "<leader>fc", ":Telescope commands<CR>", { desc = "[F]ind [C]ommands" })
    end,
  },
}
