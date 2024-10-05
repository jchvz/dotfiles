return {
  'stevarc/conform.nvim',
}
-- return {
--   'stevearc/conform.nvim',
--   config = function()
--     require('conform').setup {
--       formatters_by_ft = {
--         lua = { 'stylua' },
--         nix = { 'nixpkgs_fmt' },
--         go = { 'gofmt' },
--         --python = { 'black' },
--         --javascript = { 'prettier' },
--       },
--     }
--
--     -- Format on save
--     vim.api.nvim_create_autocmd('BufWritePre', {
--       pattern = '*',
--       callback = function()
--         require('conform').format { async = false }
--       end,
--     })
--   end,
-- }
