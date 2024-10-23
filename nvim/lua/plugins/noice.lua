return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        presets = {
          long_message_to_split = true,
        },
      }
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function() end,
  },
}
