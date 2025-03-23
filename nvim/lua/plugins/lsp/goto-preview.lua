return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  opts = {},
  config = true,
  init = function ()
    local goto_preview = require("goto-preview")

    vim.keymap.set("n", "<leader>pd", goto_preview.goto_preview_definition, {noremap=true, desc = "[P]review [D]efinitions"})
    vim.keymap.set("n", "<leader>pi", goto_preview.goto_preview_implementation, {noremap=true, desc = "[P]review [I]mplementation"})
    vim.keymap.set("n", "<leader>pD", goto_preview.goto_preview_declaration, {noremap=true, desc = "[P]review [D]eclaration"})
    vim.keymap.set("n", "<leader>pr", goto_preview.goto_preview_references, {noremap=true, desc = "[P]review [R]eferences"})
    vim.keymap.set("n", "<leader>pr", goto_preview.goto_preview_type_definition, {noremap=true, desc = "[P]review [T]ype Defintions"})
    vim.keymap.set("n", "<leader>pc", goto_preview.close_all_win, {noremap=true, desc = "[P]review [C]lose All"})
  end
}
