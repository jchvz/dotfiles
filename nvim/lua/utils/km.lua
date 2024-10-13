-- km = key maps

local M = {}

function M.get_icon(group, name, color)
  local mini = require 'mini.icons'
  return { icon = mini.get(group, name), color = color }
end

function M.set(ks, fn, d, m)
  local mode = m or 'n'

  vim.keymap.set(mode, '<leader>' .. ks, fn, { desc = d, noremap = true })
end

return M
