local km = require 'utils.km'

return {
  'folke/which-key.nvim',
  config = function()
    local wk = require 'which-key'

    wk.add {
      { '<leader>g', group = '[G]it', icon = km.get_icon('filetype', 'git', 'orange') },
      { '<leader>l', group = '[L]SP Actions', icon = km.get_icon('lsp', 'struct', 'blue') },
      { '<leader>s', group = '[S]earch', icon = km.get_icon('filetype', 'telescopeprompt', 'purple') },
    }
  end,
}
