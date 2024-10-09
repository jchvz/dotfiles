local function nixPath(bin)
  if type(bin) == 'string' then
    bin = { bin }
  end

  local result = { '/run/current-system/sw/bin/' .. bin[1] }

  for i = 2, #bin do
    table.insert(result, bin[i])
  end

  return result
end

return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconf = require 'lspconfig'
    --local capz = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local function add_lsp(server, bin, custom_config)
      custom_config = custom_config or {}

      -- Set default capabilities
      local default_config = {
        --capabilities = capz,
        cmd = nixPath(bin),
      }

      local merged_config = vim.tbl_deep_extend('force', default_config, custom_config)

      lspconf[server].setup(merged_config)
    end

    add_lsp('nil_ls', 'nil')
    add_lsp('gopls', { 'gopls', 'serve' })
    add_lsp('lua_ls', { 'lua-language-server', '-E' }, {
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
    })
  end,
}
