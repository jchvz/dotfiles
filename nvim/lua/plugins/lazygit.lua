local km = require 'utils.km'
return {
  'kdheepak/lazygit.nvim',
  lazy = true,
  cmd = {
    'LazyGit',
    'LazyGitConfig',
    'LazyGitCurrentFile',
    'LazyGitFilter',
    'LazyGitFilterCurrentFile',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    km.set('gg', ':LazyGit<CR>', 'Lazy[G]it Lez[G]o')
    km.set('gc', ':LazyGitConfig', 'Lazy[G]it [C]onfig')
  end,
}
