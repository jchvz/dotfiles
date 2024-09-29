vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
local function paste()
  local result = vim.fn.systemlist 'powershell.exe -noprofile -command Get-Clipboard'
  -- Get-Clipboard adds weird `^M` artifacts
  return vim.fn.join(
    vim.fn.map(result, function(_, line)
      return line:gsub('\r', '')
    end),
    '\n'
  )
end

vim.g.clipboard = {
  name = 'WSLClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = paste,
    ['*'] = paste,
  },
  cache_enabled = 0,
}
