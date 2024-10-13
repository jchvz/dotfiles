local M = {}

local function exec_and_strip(cmd)
  local redirect_and_strip = " 2> /dev/null | tr -d '\n'"
  return vim.fn.system(cmd .. redirect_and_strip)
end

local function format_repo_as_gh_url(repo)
  -- Example:
  -- -- input: git@github.com:jchvz/dotfiles.git
  -- -- output: https://github.com/jchvz/dotfiles/blob/
  repo = repo:gsub('^git@github.com:', 'https://github.com/')
  repo = repo:gsub('%.git$', '')
  return repo
end

local function get_gh_url()
  local repo = exec_and_strip 'git config --get remote.origin.url'
  local branch = exec_and_strip 'git branch --show-current'
  local file = vim.fn.expand '%'
  local line = vim.fn.line '.'

  repo = format_repo_as_gh_url(repo)

  return repo .. '/blob/' .. branch .. '/' .. file .. '#L' .. line
end

function M.yank_gh_url()
  local complete_url = get_gh_url()
  vim.fn.setreg('+', complete_url)
  print('Yanked: ' .. complete_url)
end

function M.open_gh_url()
  local complete_url = get_gh_url()
  vim.fn.system('wslview "' .. complete_url .. '"')
  print('Opening in browser with wslu: ' .. complete_url)
end

return M
