local km = require 'utils.km'

local function key(ks, fn, d)
  return { '<leader>' .. ks, fn, desc = d }
end

return {
  'nvim-telescope/telescope.nvim',
  keys = function() -- setting a function vs. a table overrides all defaults
    local builtins = require 'telescope.builtin'
    return {
      key('sf', builtins.find_files, '[S]earch [F]iles'),
      key('<leader>', builtins.buffers, '[ ] Pick open buffers'),
      key('sh', builtins.help_tags, '[S]earch [H]elp'),
      key('sk', builtins.keymaps, '[S]earch [K]eymaps'),
      key('sg', builtins.live_grep, '[S]earch by [G]rep'),

      key('/', function()
        builtins.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, '[/] Fuzz current buffer'),

      -- Searching particular files (neovim, nixos)
      key('snv', function()
        builtins.find_files { cwd = vim.fn.stdpath 'config' }
      end, '[S]earch [N]eo[V]im files'),

      -- TODO: handle sudo on editing configuration.nix
      key('snx', function()
        builtins.find_files { cwd = '/etc/nixos/' }
      end, '[S]earch [N]i[X]os files'),

      -- Lsp stuff
      -- Pickers
      key('ps', builtins.lsp_document_symbols, 'LS[P] Pick [S]ymbol'),
      key('pf', function()
        builtins.lsp_document_symbols { symbols = { 'method', 'function' } }
      end, 'LS[P] Pick [F]unction'),
      key('pt', function()
        builtins.lsp_document_symbols { symbols = { 'struct', 'type' } }
      end, 'LS[P] Pick [T]ype/Struct'),
      -- Gotos
      key('pd', builtins.lsp_definitions, 'LS[P] Goto [D]efinition'),
      key('py', builtins.lsp_type_definitions, 'LS[P] Goto T[Y]pe'),
    }
  end,
  config = function()
    local builtins = require 'telescope.builtin'

    -- key('sf', builtins.find_files, '[S]earch [F]iles')
  end,
}
