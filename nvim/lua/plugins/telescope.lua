local km = require 'utils.km'

local function uniform_tele_config(custom_config)
  custom_config = custom_config or {}

  local default_config = {
    layout_strategy = 'horizontal',
    layout_config = { preview_width = 2 / 3 },
  }

  local merged_config = vim.tbl_deep_extend('force', default_config, custom_config)

  return merged_config
end

return {
  'nvim-telescope/telescope.nvim',
  config = function()
    local builtins = require 'telescope.builtin'
    -- Finds
    km.set('<leader>', builtins.buffers, '[ ] Find open buffers')

    -- Searches
    km.set('sf', function()
      builtins.find_files(uniform_tele_config {
        -- Always ignore (pwd)/vendor/*
        find_command = { 'fd', '--type', 'f', '--exclude', 'vendor' },
      })
    end, '[S]earch [F]iles')

    km.set('sh', function()
      builtins.help_tags(uniform_tele_config {})
    end, '[S]earch [H]elp')

    km.set('sk', function()
      builtins.keymaps(uniform_tele_config {})
    end, '[S]earch [K]eymaps')

    km.set('sg', function()
      builtins.live_grep(uniform_tele_config {})
    end, '[S]earch by [G]rep')

    km.set('/', function()
      builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzz current buffer')

    -- Searching particular files (neovim, nixos)
    km.set('snv', function()
      builtins.find_files(uniform_tele_config {
        cwd = vim.fn.stdpath 'config',
      })
    end, '[S]earch [N]eo[V]im files')

    -- TODO: handle sudo on editing configuration.nix
    km.set('snx', function()
      builtins.find_files(uniform_tele_config {
        cwd = '/etc/nixos/',
      })
    end, '[S]earch [N]i[X]os files')
  end,
}
