-- MUST be set before setting up lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config")

-- setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "tokyonight" } },
})
