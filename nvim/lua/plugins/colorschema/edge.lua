return {
  "sainnhe/edge",
  lazy = false,
  enabled = false,
  init = function()
    vim.g.edge_style = "neon"
    vim.g.airline_theme = "edge"
    vim.g.edge_better_performance = true
    vim.g.edge_transparent_background = 2
    vim.g.edge_dim_inactive_windows = false
    vim.g.edge_enable_italic = true
    vim.g.edge_diagnostic_virtual_text = "colored"
    vim.g.edge_float_style = "bright"

    vim.cmd("colorscheme edge")

    vim.api.nvim_set_hl(0, "TabLine", { fg = "#FFFFFF", bg = "#FFFFFF", ctermbg = 50, ctermfg = 50 })
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#A0A0A0" })
  end,
}
