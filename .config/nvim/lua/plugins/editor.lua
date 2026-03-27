return { -- file manager
	"stevearc/oil.nvim",
	lazy = false, -- lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
	opts = {
		keymaps = {
			["_"] = false,
		},
		preview_win = {
			preview_method = "load",
		},
	},
	keys = {
		{
			"-",
			function()
				require("oil").open()
			end,
			desc = "Open parent directory",
		},
	},
}
