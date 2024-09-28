vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'WSLClipboard',
  copy = {
    ['+'] = 'clip.exe',
    ['*'] = 'clip.exe',
  },
  paste = {
    ['+'] = 'powershell.exe -noprofile -command Get-Clipboard',
    ['*'] = 'powershell.exe -noprofile -command Get-Clipboard',
  },
  cache_enabled = 0,
}
