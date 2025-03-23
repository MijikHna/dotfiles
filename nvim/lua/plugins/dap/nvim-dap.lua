return {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-telescope/telescope-dap.nvim",
  },
  config = function()
    local python_util = require("utils.python")
    local vscode_util = require("utils.vscode")
    local dap = require("dap")

    -- dap.set_log_level('TRACE')

    -- PYTHON
    dap.adapters.python = function(callback, config)
      if config.request == "attach" then
        callback({
          type = "server",
          port = assert(
            config.connect.port or config.port,
            "`connect.port` is required for a python `attach` configuration"
          ),
          host = config.connect.host or config.host,
          options = { source_filetype = "python" },
        })
      elseif config.request == "launch" then
        callback({
          type = "executable",
          command = python_util.get_debug_python_exec(),
          args = { "-m", "debugpy.adapter" },
          options = { source_filetype = "python" },
        })
      end
    end

    -- C++ & C
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = os.getenv("HOME")
          .. "/.vscode/extensions/"
          .. vscode_util.find_vscode_cpptools()
          .. "/debugAdapters/bin/OpenDebugAD7",
      options = { detached = false },
    }

    -- TODO: JAVA

    -- TYPESCRIPT AND JAVASCRIPT
    for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
      require("dap").adapters[adapter] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { os.getenv("HOME") .. "/prog/debugger/vscode-js-debug/src/dapDebugServer.js", "${port}" },
        },
      }
    end

    require("dap.ext.vscode").load_launchjs(".nvim/launch.json", {
      ["pwa-node"] = { "javascript", "typescript" },
      ["pwa-chrome"] = { "javascript", "typescript" },
      cppdbg = { "cpp", "c" },
      python = { "python", "yaml" },
    })

    require("nvim-dap-virtual-text").setup({})

    local dapui = require("dapui")
    local dapui_widgets = require("dap.ui.widgets")
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open({ reset = true })
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    local keymap = vim.keymap

    keymap.set("n", "<leader>dB", dap.toggle_breakpoint, { desc = "Toggle breackpoint", noremap = true })
    keymap.set("n", "<leader>db", ":PBToggleBreakpoint<CR>", { desc = "Toggle breackpoint and keep", noremap = true })
    keymap.set("n", "<leader>dPa", function()
      dap.set_exception_breakpoints({ "all" })
    end, { desc = "Set all exception breakpoints", noremap = true })
    keymap.set("n", "<leader>dPb", function()
      dap.set_exception_breakpoints(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set exception breakpoint with condition", noremap = true })
    keymap.set("n", "<leader>dPc", function()
      dap.set_exception_breakpoints(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Set log point", noremap = true })

    keymap.set("n", "<leader><S-k>", dap.step_out, { desc = "Step out", noremap = true })
    keymap.set("n", "<leader><S-l>", dap.step_into, { desc = "Step into", noremap = true })
    keymap.set("n", "<leader><S-j>", dap.step_over, { desc = "Step over", noremap = true })
    keymap.set("n", "<leader><S-h>", dap.continue, { desc = "Continue", noremap = true })
    keymap.set("n", "<leader>ds", dap.close, { desc = "Stop", noremap = true })
    keymap.set("n", "<leader>dk", dap.up, { desc = "Up", noremap = true })
    keymap.set("n", "<leader>dj", dap.down, { desc = "Down", noremap = true })
    keymap.set("n", "<leader>dd", dap.disconnect, { desc = "Disconnect", noremap = true })
    keymap.set("n", "<leader>dD", function()
      dap.disconnect({ restart = false, terminateDebugee = false })
    end, { desc = "Disconnect and keep", noremap = true })

    keymap.set("n", "<leader>dr", function()
      dap.repl.open({}, "vsplit")
      vim.cmd("C-w l")
    end, { desc = "Open REPL", noremap = true })
    keymap.set("n", "<leader>dR", dap.repl.open, { desc = "Run REPL", noremap = true })
    keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run last", noremap = true })

    keymap.set("n", "<leader>dI", dapui_widgets.hover, { desc = "Hover", noremap = true })
    keymap.set("n", "<leader>di", dapui_widgets.preview, { desc = "Preview", noremap = true })
    keymap.set("n", "<leader>dcb", function()
      dapui_widgets.center(dapui_widgets.scope)
    end, { desc = "Center and scope", noremap = true })
    keymap.set("n", "<leader>dcc", function()
      dapui_widgets.centered_float(dapui_widgets.frames)
    end, { desc = "Center and frames", noremap = true })

    keymap.set("n", "<leader>duo", dapui.open, { desc = "Open UI", noremap = true })
    keymap.set("n", "<leader>duc", dapui.close, { desc = "Close UI", noremap = true })
    keymap.set("n", "<leader>dut", dapui.toggle, { desc = "Toggle UI", noremap = true })

    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#D00000" })
    vim.api.nvim_set_hl(0, "DapBreakpointCondition", { ctermbg = 0, fg = "#61afef" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#7ce146" })
    vim.api.nvim_set_hl(0, "DapDisabled", { ctermbg = 0, fg = "#707070" })
    vim.api.nvim_set_hl(0, "DapBreakpointRejected", { ctermbg = 0, fg = "#707070" })

    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = " 󰁕", texthl = "DapStopped" })
    vim.fn.sign_define("DapDisabled", { text = " ", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapStoppedLine", { text = " 󰁕", texthl = "DapStoppedLine" })
  end,
}
