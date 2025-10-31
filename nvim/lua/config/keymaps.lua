local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = ","

keymap.set("n", "<leader><CR>", "o<ESC>", { desc = "Add new line in normal mode" })
keymap.set("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlights" })
-- keymap.set("n", "<C-s>", general_util.format_on_save, { desc = "Format on save" })

-- splits
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Horizontal split" })
keymap.set("n", "<leader>sq", ":q<CR>", { desc = "Close window" })
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Close other windows" })

-- tabs
keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tN", ":tabnew %<CR>", { desc = "Open current buffer in new tab" })
keymap.set("n", "<leader>tq", ":tabclose<CR>", { desc = "Close tab" })
keymap.set("n", "<leader>tp", ":tabprev<CR>", { desc = "Previous tab" })
keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })

-- keymap.set("n", "<C-s>", general_util.format_on_save, { desc = "Format on save" })

-- cursor postioning
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half page" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half page" })

keymap.set("n", "n", "nzzzv", { desc = "Move to next search result", noremap = true })
keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search result", noremap = true })

keymap.set("x", "<leader>p", "_dP", { desc = "Paste without overwriting clipboard" })

-- copy
keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy to clipboard" })

-- replace
keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace" })
keymap.set("v", "<leader>ss", [[y:s/\<<C-r><C-w>\>/.../gI<Left><Left>]], { desc = "Search and replace" })

keymap.set("i", "C-i", "<Esc>ea", { desc = "Leave insert mode and move cursor to the end of the word", noremap = true })

-- delete
keymap.set({ "n" }, "<leader>dD", '"_dd', { desc = "Delete line without overwriting clipboard", noremap = true })
keymap.set({ "n", "v" }, "<leader>D", '"_D', { desc = "Delete line without overwriting clipboard", noremap = true })
keymap.set({ "v" }, "<leader>d", '"_d', { desc = "Delete without overwriting clipboard", noremap = true })
