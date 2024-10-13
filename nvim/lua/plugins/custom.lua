local km = require 'utils.km'

return {
  {
    dir = '', -- why
    dev = true,
    name = 'open_gh',
    config = function()
      local open_gh = require 'custom.open-github'
      km.set('gy', open_gh.yank_gh_url, '[G]ithub [Y]ank link')
      km.set('gb', open_gh.open_gh_url, '[G]ithub [B]rowse to link')
    end,
  },
}
