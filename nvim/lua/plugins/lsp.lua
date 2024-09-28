local lsp_utils = require 'utils.lsp'
local km = require 'utils.km'

return {
  'neovim/nvim-lspconfig',
  config = function()
    local nvim_lsp = require 'lspconfig'

    local capz = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- All LSP servers get cool keybindings
    km.setkm('lr', lsp_utils.rename_symbol, '[L]sp [R]ename')
    km.setkm('lh', vim.lsp.buf.hover, '[L]sp [H]over')
    km.setkm('lu', lsp_utils.find_usages, '[L]sp [U]sages')

    -- Lua specific config
    local lua_ls_binary = '/run/current-system/sw/bin/lua-language-server'
    nvim_lsp.lua_ls.setup {
      cmd = { lua_ls_binary, '-E' },
      capabilities = capz,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = vim.split(package.path, ';'),
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- Nix specific config
    nvim_lsp.nil_ls.setup {
      capabilities = capz,
    }

    -- Golang specific config
    nvim_lsp.gopls.setup {
      capabilities = capz,
    }
  end,
}
