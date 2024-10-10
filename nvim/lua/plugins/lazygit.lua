local km = require 'utils.km'
return {
  'kdheepak/lazygit.nvim',
  lazy = false,
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
    km.set('gg', ':LazyGit<CR>', '[G]it [G]UI') -- calling it `"Lazy[G]it" adds the zzz icons`
    km.set('gc', ':LazyGitConfig', '[G]it [C]onfig')
  end,
}
