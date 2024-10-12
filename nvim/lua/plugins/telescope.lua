local km = require 'utils.km'

return {
  'nvim-telescope/telescope.nvim',
  opts = {},
  config = function()
    require('telescope').setup {
      defaults = {
        -- Default configuration for telescope goes here:
        layout_strategy = 'horizontal',
        sorting_strategy = 'ascending',
        layout_config = {
          preview_width = 2 / 3,
          horizontal = { prompt_position = 'top' },
        },
        file_ignore_patterns = { 'node_modules', 'vendor' },
        -- mappings = {
        --   i = {
        --     ['<C-h>'] = 'which_key',
        --   },
        -- },
      },
    }

    local builtins = require 'telescope.builtin'
    -- Finds
    km.set('<leader>', builtins.buffers, '[ ] Find open buffers')

    -- Searches
    km.set('sf', builtins.find_files, '[S]earch [F]iles')
    km.set('sh', builtins.help_tags, '[S]earch [H]elp')
    km.set('sk', builtins.keymaps, '[S]earch [K]eymaps')

    km.set('sg', builtins.live_grep, '[S]earch by [G]rep')

    km.set('/', function()
      builtins.current_buffer_fuzzy_find {
        winblend = 10,
        previewer = false,
        layout_config = { height = 0.5 },
        sorting_strategy = 'ascending',
      }
    end, '[/] Fuzz current buffer')

    -- Searching particular files (neovim, nixos)
    km.set('snv', function()
      builtins.find_files {
        cwd = vim.fn.stdpath 'config',
      }
    end, '[S]earch [N]eo[V]im files')

    -- TODO: handle sudo on editing configuration.nix
    km.set('snx', function()
      builtins.find_files {
        cwd = '/etc/nixos/',
      }
    end, '[S]earch [N]i[X]os files')
  end,
}
