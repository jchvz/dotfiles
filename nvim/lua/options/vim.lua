vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.background = 'light'
vim.cmd 'colorscheme vim' -- avoids flash of color before everforest load

-- Clipboard
vim.opt.clipboard = 'unnamedplus'
vim.g.clipboard = {
  name = 'WSLClipboard',
  copy = {
    ['+'] = 'win32yank.exe -i',
    ['*'] = 'win32yank.exe -i',
  },
  paste = {
    ['+'] = 'win32yank.exe -o',
    ['*'] = 'win32yank.exe -o',
  },
  cache_enabled = 0,
}
