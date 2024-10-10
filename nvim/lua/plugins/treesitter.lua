return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'javascript',
      'json',
      'jsonc',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'regex',
      'svelte',
      'toml',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    auto_install = true,
    highlight = {
      enable = true,
    },

    -- Can't find textobjects in path
    -- textobjects = {
    --   move = {
    --     enable = true,
    --     goto_next_start = {
    --       [']f'] = '@function.outer',
    --       [']c'] = '@class.outer',
    --       [']a'] = '@parameter.inner',
    --     },
    --     goto_next_end = {
    --       [']F'] = '@function.outer',
    --       [']C'] = '@class.outer',
    --       [']A'] = '@parameter.inner',
    --     },
    --     goto_previous_start = {
    --       ['[f'] = '@function.outer',
    --       ['[c'] = '@class.outer',
    --       ['[a'] = '@parameter.inner',
    --     },
    --     goto_previous_end = {
    --       ['[F'] = '@function.outer',
    --       ['[C'] = '@class.outer',
    --       ['[A'] = '@parameter.inner',
    --     },
    --   },
    -- },
  },
  -- Comment from kickstarter:
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}
