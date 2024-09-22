-- lua/plugins/lsp.lua

return {
  'neovim/nvim-lspconfig',
  config = function()
    local nvim_lsp = require('lspconfig')

    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Set the command to the lua-language-server binary
    local lua_ls_binary = "/run/current-system/sw/bin/lua-language-server"

    -- Configure LSP for Lua
    nvim_lsp.lua_ls.setup {
      cmd = {lua_ls_binary, "-E"},
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- LuaJIT in Neovim uses Lua 5.1 by default
            version = 'LuaJIT',
            path = vim.split(package.path, ';'



            ),
          },
          diagnostics = {
            globals = {'vim'},  -- Recognize 'vim' as a global variable
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,  -- Disable unnecessary third-party library check prompt
          },
          telemetry = {
            enable = false,  -- Disable telemetry for privacy
          },
        },
      },
    }
  end
}

