return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		explorer = { replace_netrw = true },
		indent = {},
		picker = {
			sources = {
				explorer = {},
			},
		},
	},
	keys = {
		{
			"<leader><Space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"-",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
	},
}
