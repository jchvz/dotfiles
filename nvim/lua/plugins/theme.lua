--vim.opt.background = "light"
vim.o.background = "light"
vim.g.everforest_background = "soft" -- Options: 'soft', 'medium', 'hard'

return {
  "sainnhe/everforest",
  config = function()
    vim.g.everforest_enable_italic = 0
    vim.cmd("colorscheme everforest")
  end,
}
