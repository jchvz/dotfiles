local km = require 'utils.km'

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

  dependencies = {
    'hrsh7th/nvim-cmp',
  },

  config = function()
    local lspconf = require 'lspconfig'
    local capz = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- Helper for registering LSP servers
    local function add_lsp(server, bin, custom_config)
      custom_config = custom_config or {}

      local default_config = {
        capabilities = capz,
        cmd = nixPath(bin),
      }

      local merged_config = vim.tbl_deep_extend('force', default_config, custom_config)

      lspconf[server].setup(merged_config)
    end

    -- Register all LSP servers
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

    local tele = require 'telescope.builtin'

    local function lsp_icn(name)
      return km.get_icon('lsp', name, 'blue').icon
    end

    km.set('lh', vim.lsp.buf.hover, '[L]SP [H]over')
    km.set('ld', tele.lsp_definitions, lsp_icn 'event' .. '[L]SP [D]efinition') -- fairly grim if there are multiple but it can happen
    km.set('lr', tele.lsp_references, lsp_icn 'reference' .. '[L]SP [R]eferences')
    km.set('l2', vim.lsp.buf.rename, '[L]SP Rename X[2]Y')
    km.set('lt', tele.lsp_type_definitions, lsp_icn 'typeparameter' .. '[L]SP [T]ypeDef')
    km.set('li', tele.lsp_implementations, '[L]SP [I]mplementations')

    -- Symbol pickers
    km.set('ls', tele.lsp_document_symbols, '[L]SP [S]ymbols')
    km.set('lf', function()
      tele.lsp_document_symbols { symbols = { 'function', 'method' } }
    end, lsp_icn 'function' .. '[L]SP [F]unctions')
    km.set('lo', function()
      tele.lsp_document_symbols { symbols = { 'variable', 'constant' } }
    end, lsp_icn 'object' .. '[L]SP [O]bjects')
  end,
}
