-- Editing
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clipboard
-- Unfortunately, we have to presuppose that Windows has been configured with win32yank.exe
-- installed + on the path. For posterity, the install script used in PowerShell on Windows:
-- winget install --id=equalsraf.win32yank -e
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "WSLClipboard",
  copy = {
    ["+"] = "win32yank.exe -i",
    ["*"] = "win32yank.exe -i",
  },
  paste = {
    ["+"] = "win32yank.exe -o",
    ["*"] = "win32yank.exe -o",
  },
  --   cache_enabled = 0,
}
