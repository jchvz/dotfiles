local function setkm(ks, fn, d)
  vim.keymap.set('n', '<leader>' .. ks, fn, { desc = d })
end

return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require 'telescope.builtin'
    -- Finds
    setkm('<leader>', builtin.buffers, '[ ] Find open buffers')
    -- Searches
    setkm('sh', builtin.help_tags, '[S]earch [H]elp')
    setkm('sk', builtin.keymaps, '[S]earch [K]eymaps')
    setkm('sg', builtin.live_grep, '[S]earch by [G]rep')
    setkm('sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, '[S]earch [N]eovim files')
    -- Daily use
    setkm('/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, '[/] Fuzz current buffer')
    --setkm('sk', builtin.keymaps, '[S]earch [K]eymaps')
  end,
}
