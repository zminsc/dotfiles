--- Globals ---
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable certain healthchecks
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

--- Options ---
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

vim.o.autoindent = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

vim.o.textwidth = 80
vim.o.formatoptions = "cro"

vim.o.wrapscan = true
vim.o.hlsearch = false

vim.o.swapfile = false
vim.o.undofile = true

vim.o.scrolloff = 999

--- Diagnostics ---
vim.diagnostic.config({
	update_in_insert = true,
})

--- Plugins ---
vim.pack.add({
	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },

	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },

	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Auto-complete
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },

	-- QoL
	{ src = "https://github.com/nvim-mini/mini.nvim", version = "stable" },
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/farmergreg/vim-lastplace" },
	{ src = "https://github.com/tpope/vim-sleuth" },
})

--- Treesitter ---
require("nvim-treesitter").install({
	"bash",
	"javascript",
	"lua",
	"markdown",
	"tsx",
	"typescript",
})

--- LSP ---
require("mason").setup()
require("mason-lspconfig").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"bash-language-server",
		"eslint",
		"lua_ls",
		"prettierd",
		"stylua",
		"tsgo",
	},

	-- Check for updates once per day
	auto_update = true,
	run_on_start = true,
	debounce_hours = 24,
})

--- Formatting ---
require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		typescript = { "prettierd" },
	},
	format_on_save = {
		timeout_ms = 2500,
	},
})

--- Auto-complete ---
require("blink.cmp").build()

require("blink.cmp").setup({
	completion = {
		documentation = {
			auto_show = false,
		},
		list = { selection = { auto_insert = false } },
		trigger = {
			show_on_keyword = false,
			show_on_trigger_character = false,
			show_on_insert = false,
		},
	},
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "fallback" },
		["<Esc>"] = { "hide", "fallback" },
		["<C-n>"] = { "select_next", "fallback" },
		["<C-p>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "accept", "fallback" },
		["<Enter>"] = { "accept", "fallback" },
	},
	sources = { default = { "lsp", "path", "buffer" } },
})

--- QoL ---

-- Icons
require("mini.icons").setup()

-- Picker
require("mini.pick").setup()

-- File explorer
require("mini.files").setup()

-- Neovim config development
require("lazydev").setup()

-- Colorscheme
require("tokyonight").setup({
	on_colors = function(_) end,
	on_highlights = function(_, _) end,
})

vim.cmd([[colorscheme tokyonight-night]])

--- Keymaps ---
vim.keymap.set("n", "<leader><leader>", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "-", MiniFiles.open)
