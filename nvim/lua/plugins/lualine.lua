local function connected_lsps()
  local lsps_on_this_buf = {}

  local clients = vim.lsp.get_clients()

  if next(clients) == nil then
    return [[blind]]
  end

  for _, client in ipairs(clients) do
    if vim.lsp.buf_is_attached(0, client.id) then
      table.insert(lsps_on_this_buf, client.name)
    end
  end

  local mini = require 'mini.icons'
  return mini.get('lsp', 'struct') .. ' ' .. table.concat(lsps_on_this_buf, ', ')
end

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'echasnovski/mini.icons',
  },
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = ' '
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    local mini = require 'mini.icons'
    local gitIcon = mini.get('file', '.git') --'󰊢'
    local lspIcon = mini.get('lsp', 'struct')
    return {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'dashboard' },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {},
        lualine_x = { 'filetype' },
        lualine_y = { 'diagnostics', connected_lsps },
        lualine_z = {
          function()
            return mini.get('os', 'nixos')
          end,
        },
      },
    }
  end,
}
