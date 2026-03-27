return {
	{ -- auto-adjust tabstop based on current file
		"tpope/vim-sleuth",
	},
	{ -- open file where you last closed it
		"farmergreg/vim-lastplace",
		event = "BufReadPost",
	},
	{ -- properly configure lua_ls for editing neovim config
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
}
