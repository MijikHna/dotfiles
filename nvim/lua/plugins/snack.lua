return {
  "folke/snacks.nvim",
  enabled = true,
  ---@type snacks.Config
  opts = {
    bigfile = {
      enabled = false,
      size = 3 * 1024 * 1024, -- 3MB
      line_length = 10000,
    },
    rename = { enabled = true },
    image = { enabled = false },
    debug = { enabled = false },
    dim = { enabled = false },
    indent = { enabled = false },
    explorer = { enabled = false },
  },
  init = function ()
    local prev = { new_name = "", old_name = "" } -- Prevents duplicate events

    vim.api.nvim_create_autocmd("User", {
      pattern = "NvimTreeSetup",
      callback = function ()
        local events = require("nvim-tree.api").events
        events.subscribe(events.Event.NodeRenamed, function (data)
          if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
            data = data
            Snacks.rename.on_rename_file(data.old_name, data.new_name)
          end
        end)
      end,
    })
  end,
}
