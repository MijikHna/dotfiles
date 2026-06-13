local keys = vim.keymap

-- vim.pack.add({"https://github.com/nvim-pack/nvim-spectre"})
--
-- keys.set("n", "<leader>sr", "<cmd>lua require('spectre').open()<CR>", { noremap = true, desc = "Open Spectre" })
--
-- keys.set("n", "<leader>sv", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", { noremap = true, desc = "Open Spectre Visual" })
-- keys.set("n", "<leader>sw", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",{ noremap = true, desc = "Open Spectre with Word under Cursor" })

vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" })

require("grug-far")

keys.set("n", "<leader>sr", "<cmd>lua require('grug-far').open()<CR>",
  { noremap = true, desc = "Open Search and Replace" })
keys.set("n", "<leader>sv", "<cmd>lua require('grug-far').with_visual_selection()<CR>",
  { noremap = true, desc = "Open Search and Replace Word" })
keys.set("n", "<leader>sw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>')}})<CR>",
  { noremap = true, desc = "Open Search and Replace Word" })
