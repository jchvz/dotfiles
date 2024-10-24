return {
  'hrsh7th/nvim-cmp',
  version = false, -- basically == master
  event = 'InsertEnter',
  dependencies = {
    -- From the big guy himself
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
        enabled = function()
          -- Don't enable any snippets when I'm in a goddang comment.
          local context = require 'cmp.config.context'
          return (not context.in_treesitter_capture 'comment' and not context.in_treesitter_capture 'Comment')
        end,
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        formatting = {
          format = function(entry, vim_item)
            if not entry or not vim_item or not vim_item.kind then
              return vim_item -- Return unchanged if nil values are found
            end
            -- Eliminate all "Text" completions
            if vim_item.kind == 'Text' then
              print 'cowabunga'
              return nil
            end
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert {
          -- navigating the completion menu
          ['<Down>'] = cmp.mapping.select_next_item(),
          ['<Up>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<Tab>'] = cmp.mapping.confirm { select = true }, -- sometimes I do this

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
        },
      },
    }
  end,
}
