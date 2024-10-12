local km = require 'utils.km'

return {
  {
    dir = '', -- why
    dev = true,
    name = 'open_gh',
    config = function()
      local open_gh = require 'custom.open-github'
      km.set('gh', open_gh.get_repo_path, 'Yank github link')
    end,
  },
}
