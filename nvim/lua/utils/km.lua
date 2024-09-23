-- km = key maps

local M = {}

function M.setkm(ks, fn, d)
  vim.keymap.set('n', '<leader>' .. ks, fn, { desc = d, noremap = true })
end

return M
