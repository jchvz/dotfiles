-- init.lua

local function ends_with(str, ending)
  if str == nil then
    return false
  end -- Safeguard against nil values
  return ending == '' or str:sub(-#ending) == ending
end

-- Load options (all the Lua files in the options/ folder)
local options_dir = vim.fn.stdpath 'config' .. '/lua/options/'
for _, file in ipairs(vim.fn.readdir(options_dir)) do
  if ends_with(file, '.lua') then
    local file_name = file:match '(.+)%..+'
    if file_name then
      require('options.' .. file_name)
    end
  end
end

-- Load plugin specifications from lua/plugins/
local plugins = {}

local plugins_dir = vim.fn.stdpath 'config' .. '/lua/plugins/'
for _, file in ipairs(vim.fn.readdir(plugins_dir)) do
  local file_name = file:match '(.+)%..+'
  if file_name then
    local plugin_spec = require('plugins.' .. file_name)
    if type(plugin_spec) == 'table' then
      table.insert(plugins, plugin_spec)
    end
  end
end

-- Setup Lazy.nvim with the found plugins
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(plugins)
