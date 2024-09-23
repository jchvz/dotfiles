local km = require 'utils.km'
--local builtins = require('telescope.builtin')

local function open_telescope_on_dir()
  local bufname = vim.fn.expand '%:p'
  if vim.fn.isdirectory(bufname) == 1 then
    require('telescope.builtin').find_files()
  end
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtins = require 'telescope.builtin'

    -- Finds
    km.setkm('<leader>', builtins.buffers, '[ ] Find open buffers')
    -- Searches
    km.setkm('sf', builtins.find_files, '[S]earch [F]iles')
    km.setkm('sh', builtins.help_tags, '[S]earch [H]elp')
    km.setkm('sk', builtins.keymaps, '[S]earch [K]eymaps')
    km.setkm('sg', builtins.live_grep, '[S]earch by [G]rep')

    -- Daily use
    km.setkm('/', function()
      builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzz current buffer')

    -- Searching particular files (neovim, nixos)
    km.setkm('snv', function()
      builtins.find_files { cwd = vim.fn.stdpath 'config' }
    end, '[S]earch [N]eo[V]im files')

    -- TODO: handle sudo on editing configuration.nix
    km.setkm('snx', function()
      builtins.find_files { cwd = '/etc/nixos/' }
    end, '[S]earch [N]i[X]os files')

    -- Autocommands
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = open_telescope_on_dir,
    })
  end,
}
