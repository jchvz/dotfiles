-- TODO: fix
local km = require 'utils.km'

return {
  'MagicDuck/grug-far.nvim',
  opts = { headerMaxWidth = 80 },
  cmd = 'GrugFar',
  config = function()
    km.set('sr', function()
      local grug = require 'grug-far'
      local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
      grug.open {
        transient = true,
        prefills = {
          filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
        },
      }
    end, '[S]earch and [R]eplace (grug)')
  end,
}
