-- km = key maps

local M = {}

function M.set(ks, fn, d, m)
  local mode = m or 'n'

  local mini = require 'mini.icons'

  -- Lil helper for adding icons to whichkey descriptions
  -- Added before I knew about whichkey registration
  local prefixes = {
    ['[L]SP [F]'] = mini.get('lsp', 'function'),
    ['[L]SP [R]'] = mini.get('lsp', 'reference'),
    ['[L]SP [I]'] = mini.get('lsp', 'string'),
    ['[L]SP [O]'] = mini.get('lsp', 'object'),
    ['[L]SP [S]'] = mini.get('lsp', 'variable'),
    ['[L]SP [T]'] = mini.get('lsp', 'typeparameter'),
    ['[L]SP [D]'] = mini.get('lsp', 'event'),
    ['[S]'] = mini.get('filetype', 'telescopeprompt'), -- Search (telescope) bindings
    ['[G]'] = mini.get('filetype', 'git'),
  }
  for prefix, icon in pairs(prefixes) do
    if d:sub(1, #prefix) == prefix then
      d = icon .. ' ' .. d -- prepend icon to description
      break -- multiple icons might be cool
    end
  end

  vim.keymap.set(mode, '<leader>' .. ks, fn, { desc = d, noremap = true })
end

return M
