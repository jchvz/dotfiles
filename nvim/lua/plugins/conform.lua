return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'nixpkgs_fmt' },
        --python = { 'black' },
        --javascript = { 'prettier' },
        -- Add more filetypes and formatters as needed
      },
    }

    -- Format on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function()
        require('conform').format { async = false }
      end,
    })
  end,
}