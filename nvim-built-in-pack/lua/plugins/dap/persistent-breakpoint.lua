vim.pack.add({"http://github.com/catppuccin/nvim"})

require('persistent-breakpoints').setup({
    save_dir = vim.fn.stdpath("data") .. "/breakpoints",
    load_breakpoints_event = { "BufReadPost" },
    perf_record = false,
})
