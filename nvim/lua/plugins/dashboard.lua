return {
  'nvimdev/dashboard-nvim',
  lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
  opts = function()
    local logo = [[
    
______/\\\\\\\\\\\________/\\\\\\\\\__/\\\________/\\\__/\\\________/\\\__/\\\\\\\\\\\\\\\_        
 _____\/////\\\///______/\\\////////__\/\\\_______\/\\\_\/\\\_______\/\\\_\////////////\\\__       
  _________\/\\\_______/\\\/___________\/\\\_______\/\\\_\//\\\______/\\\____________/\\\/___      
   _________\/\\\______/\\\_____________\/\\\\\\\\\\\\\\\__\//\\\____/\\\___________/\\\/_____     
    _________\/\\\_____\/\\\_____________\/\\\/////////\\\___\//\\\__/\\\__________/\\\/_______    
     _________\/\\\_____\//\\\____________\/\\\_______\/\\\____\//\\\/\\\_________/\\\/_________   
      __/\\\___\/\\\______\///\\\__________\/\\\_______\/\\\_____\//\\\\\________/\\\/___________  
       _\//\\\\\\\\\_________\////\\\\\\\\\_\/\\\_______\/\\\______\//\\\________/\\\\\\\\\\\\\\\_ 
        __\/////////_____________\/////////__\///________\///________\///________\///////////////__
    ]]

    logo = string.rep('\n', 8) .. logo .. '\n\n'

    local opts = {
      theme = 'doom',
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, '\n'),
        -- stylua: ignore
        center = {
          { action = 'Telescope find_files',                            desc = " Find File",       icon = " ", key = "f" },
          { action = 'Telescope live_grep',                             desc = " Live Grep",       icon = " ", key = "g" },
          { action = "ene | startinsert",                               desc = " New File",        icon = " ", key = "n" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end,  desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require('lazy').stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(' ', 43 - #button.desc)
      button.key_format = '  %s'
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == 'lazy' then
      vim.api.nvim_create_autocmd('WinClosed', {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds('UIEnter', { group = 'dashboard' })
          end)
        end,
      })
    end

    return opts
  end,
}
