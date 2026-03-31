-- options --

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.scrolloff = 999

-- plugins --

vim.pack.add({
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/farmergreg/vim-lastplace",
	"https://github.com/folke/snacks.nvim",
})

-- colorscheme --

vim.cmd.colorscheme("tokyonight-night")

-- lsp --

require("mason").setup()
require("mason-lspconfig").setup()
require("lazydev").setup({
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

-- formatting --

require("conform").setup({
	format_on_save = { timeout_ms = 500, lsp_fallback = true },
	formatters_by_ft = {
		html = { "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		javascript = { "prettierd" },
	},
})

-- plugins --

require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "snacks_layout_box",
				highlight = "Directory",
			},
		},
	},
})

require("lualine").setup({})

require("gitsigns").setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

-- snacks --

local Snacks = require("snacks")

Snacks.setup({
	explorer = {
		replace_netrw = true,
	},
	indent = {},
	picker = {
		sources = {
			explorer = {
				win = {
					list = {
						keys = {
							["o"] = "explorer_add",
						},
					},
				},
			},
		},
	},
})

vim.keymap.set("n", "<leader><Space>", Snacks.picker.smart)
vim.keymap.set("n", "<leader>,", Snacks.picker.buffers)
vim.keymap.set("n", "<leader>/", Snacks.picker.grep)
vim.keymap.set("n", "-", Snacks.explorer.open)

-- keymaps --

vim.keymap.set("n", "<leader>t", "<C-^>", { noremap = true, desc = "Toggle to alternate buffer" })

-- autocmds --

vim.api.nvim_create_autocmd("BufEnter", {
	-- remove comment on newline
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

vim.api.nvim_create_autocmd("QuitPre", {
	-- quit Snacks explorer if it is the only window left
	-- credit: https://karn.work/blog/2025/2025-03-30-quit_neovim_when_window_is_last_and_snacks_explorer_still_open
	callback = function()
		local snacks_windows = {}
		local floating_windows = {}
		local windows = vim.api.nvim_list_wins()
		for _, w in ipairs(windows) do
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
			if filetype:match("snacks_") ~= nil then
				table.insert(snacks_windows, w)
			elseif vim.api.nvim_win_get_config(w).relative ~= "" then
				table.insert(floating_windows, w)
			end
		end
		if 1 == #windows - #floating_windows - #snacks_windows then
			-- Should quit, so we close all Snacks windows.
			for _, w in ipairs(snacks_windows) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})
