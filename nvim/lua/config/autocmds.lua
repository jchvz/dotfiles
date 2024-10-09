-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Format on save
-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*',
--   callback = function()
--     require('conform').format { async = false }
--   end,
-- })
