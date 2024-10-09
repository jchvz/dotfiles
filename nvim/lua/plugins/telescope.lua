local km = require 'utils.km'

return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local builtins = require 'telescope.builtin'
    -- Finds
    km.set('<leader>', builtins.buffers, '[ ] Find open buffers')
    -- Searches
    km.set('sf', builtins.find_files, '[S]earch [F]iles')
    km.set('sh', builtins.help_tags, '[S]earch [H]elp')
    km.set('sk', builtins.keymaps, '[S]earch [K]eymaps')
    km.set('sg', builtins.live_grep, '[S]earch by [G]rep')

    -- Daily use
    km.set('/', function()
      builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzz current buffer')

    -- Searching particular files (neovim, nixos)
    km.set('snv', function()
      builtins.find_files { cwd = vim.fn.stdpath 'config' }
    end, '[S]earch [N]eo[V]im files')

    -- TODO: handle sudo on editing configuration.nix
    km.set('snx', function()
      builtins.find_files { cwd = '/etc/nixos/' }
    end, '[S]earch [N]i[X]os files')
  end,
}
