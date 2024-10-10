return {
  'hrsh7th/nvim-cmp',
  version = false, -- basically == master
  event = 'InsertEnter',
  dependencies = {
    -- From the big guy
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    -- Snippets
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

    luasnip.config.setup {
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        sources = {
          -- {
          --   name = 'lazydev',
          --   -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          --   group_index = 0,
          -- },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },

        mapping = cmp.mapping.preset.insert {
          -- basic completion menu
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
          -- both are common for accepting completion
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.confirm { select = true },

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },
      },
    }
  end,
}
