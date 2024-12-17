return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local lga_actions = require("telescope-live-grep-args.actions")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "filename_first" },
          file_ignore_patterns = {
            "node_modules/",
            "dist/",
            "venv",
            ".venv",
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
            "package%-lock%.json",
          },
          mappings = {
            i = {
              ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
              ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
          layout_strategy = "center",
          layout_config = { height = 0.35, width = 0.55 }, --center
          -- layout_config = { height = 0.90, width = 0.55 }, -- vertical
          prompt_position = "bottom",
        },
        pickers = {
          find_files = { hidden = true },
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
            fuzzy = false, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })

      telescope.load_extension("live_grep_args")
      require("telescope").load_extension("notify")

      local keymap = vim.keymap
      keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
      keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
      keymap.set("n", "<leader>fS", ":Telescope grep_string<CR>", { desc = "Grep string" })
      keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
      keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help tags" })
      keymap.set("n", "<leader>fl", ":Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" })
      keymap.set("n", "<leader>fs", ":Telescope lsp_workspace_symbols<CR>", { desc = "LSP workspace symbols" })
      keymap.set("n", "<leader>ft", ":Telescope treesitter<CR>", { desc = "Treesitter" })
      keymap.set("n", "<leader>fd", ":Telescope lsp_definitions<CR>", { desc = "LSP definitions" })
      keymap.set("n", "<leader>fr", ":Telescope lsp_references<CR>", { desc = "LSP references" })
      keymap.set("n", "<leader>fw", ":Telescope grep_string<CR>", { desc = "Grep string" })
      keymap.set("n", "<leader>fd", ":Telescope diagnostics<CR>", { desc = "Diagnostics" })
      keymap.set("n", "<leader>fc", ":Telescope commands<CR>", { desc = "Commands" })
      keymap.set("n", "<leader>fo", ":Telescope lsp_outgoing_calls<CR>", { desc = "Outgoing calls" })
      keymap.set("n", "<leader>fi", ":Telescope lsp_incoming_calls<CR>", { desc = "Outgoing calls" })
      keymap.set("n", "<leader>ff", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Current buffer fuzzy find" })
      keymap.set("n", "<leader>fG", ":Telescope live_grep_args<CR>", { desc = "Live grep args" })
      keymap.set("n", "<leader>fS", ":Telescope grep_string<CR>", { desc = "Grep string" })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
