return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
    'hrsh7th/cmp-buffer', -- Buffer completions
    'hrsh7th/cmp-path', -- Path completions
    'hrsh7th/cmp-cmdline', -- Command-line completions
    'L3MON4D3/LuaSnip', -- Snippet engine
    'saadparwaiz1/cmp_luasnip', -- Snippet completions
  },
  config = function()
    -- Setup nvim-cmp.
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    cmp.setup {
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<S-Tab>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
      },
    }

    -- Setup buffer-specific completion for gitcommit files
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources {
        { name = 'cmp_git' }, -- You can specify git source if using cmp_git
        { name = 'buffer' },
      },
    })

    -- Use buffer source for `/` and `?` in command-line mode
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' in command-line mode
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
