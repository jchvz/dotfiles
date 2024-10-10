return {
  'sainnhe/everforest',
  priority=1000, -- import it first
  config = function()
    vim.g.everforest_enable_italic = 0
    vim.cmd.colorscheme('everforest')
  end,
}
