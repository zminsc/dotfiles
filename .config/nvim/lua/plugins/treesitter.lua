return { -- treesitter
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = { "lua", "vim" },
		auto_install = true,
	},
}
