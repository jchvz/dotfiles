-- lua/plugins/theme.lua

local solarized_light = {
  base03 = '#002b36',
  base02 = '#073642',
  base01 = '#586e75',
  base00 = '#657b83',
  base0 = '#839496',
  base1 = '#93a1a1',
  base2 = '#eee8d5',
  base3 = '#fdf6e3',
  yellow = '#b58900',
  orange = '#cb4b16',
  red = '#dc322f',
  magenta = '#d33682',
  violet = '#6c71c4',
  blue = '#268bd2',
  cyan = '#2aa198',
  green = '#859900',
}

-- Apply the color scheme
local function apply_colorscheme()
  local highlight = vim.api.nvim_set_hl

  -- Set the background and foreground
  vim.o.background = 'light'
  vim.o.termguicolors = true

  -- Define basic highlights
  highlight(0, 'Normal', { fg = solarized_light.base00, bg = solarized_light.base3 })
  highlight(0, 'Comment', { fg = solarized_light.base1, italic = true })
  highlight(0, 'Constant', { fg = solarized_light.blue })
  highlight(0, 'String', { fg = solarized_light.cyan })
  highlight(0, 'Variable', { fg = solarized_light.blue })
  highlight(0, 'Function', { fg = solarized_light.green })
  highlight(0, 'Keyword', { fg = solarized_light.red, bold = true })
  highlight(0, 'Type', { fg = solarized_light.yellow })

  -- UI elements
  highlight(0, 'LineNr', { fg = solarized_light.base01, bg = solarized_light.base3 })
  highlight(0, 'CursorLine', { bg = solarized_light.base2 })
  highlight(0, 'CursorLineNr', { fg = solarized_light.red, bg = solarized_light.base2 })
  highlight(0, 'StatusLine', { fg = solarized_light.base1, bg = solarized_light.base02 })
  highlight(0, 'StatusLineNC', { fg = solarized_light.base01, bg = solarized_light.base2 })
  highlight(0, 'Pmenu', { bg = solarized_light.base2, fg = solarized_light.base00 })
  highlight(0, 'PmenuSel', { bg = solarized_light.blue, fg = solarized_light.base3 })

  -- Diagnostics and Git
  highlight(0, 'DiagnosticError', { fg = solarized_light.red })
  highlight(0, 'DiagnosticWarn', { fg = solarized_light.yellow })
  highlight(0, 'DiagnosticInfo', { fg = solarized_light.blue })
  highlight(0, 'DiagnosticHint', { fg = solarized_light.cyan })
  highlight(0, 'GitGutterAdd', { fg = solarized_light.green })
  highlight(0, 'GitGutterChange', { fg = solarized_light.blue })
  highlight(0, 'GitGutterDelete', { fg = solarized_light.red })

  -- Customizing the Status Line
  highlight(0, 'StatusLine', { fg = solarized_light.base1, bg = solarized_light.base02 })
  highlight(0, 'StatusLineNC', { fg = solarized_light.base01, bg = solarized_light.base2 })

  -- Add more highlight groups as needed for your preferences
end

-- Automatically apply the theme on startup
apply_colorscheme()
