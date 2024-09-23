local M = {}

function M.rename_symbol()
  local current_name = vim.fn.expand '<cword>'
  local new_name = vim.fn.input('Rename ' .. current_name .. ' to: ')

  if new_name == '' or new_name == current_name then
    return
  end

  -- Perform LSP rename
  vim.lsp.buf.rename(new_name)

  -- Optionally, show all references of the renamed symbol across the project using Telescope
  require('telescope.builtin').lsp_references {
    prompt_title = 'References of ' .. current_name,
    include_declaration = true,
    fname_width = 80,
    layout_config = {
      horizontal = { preview_width = 0.6 },
    },
  }
end

return M
