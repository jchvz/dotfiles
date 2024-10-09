vim.opt.rtp:prepend("/home/john/dotfiles/vendor/lazy.nvim");

-- Before lazy, import all options
require("options.vim")

-- Now import all plugins with lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})

