-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- MUST be set before setting up lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- persistent undo
vim.opt.undofile = true

-- natural window splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- in general, whitespace for tabs, 4 spaces for tab size
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

-- auto-indent
vim.opt.smartindent = true

-- remove highlighting
vim.opt.hlsearch = false

-- keep cursor in middle of screem
vim.opt.scrolloff = 999

-- remap keymap to open previous buffer
vim.keymap.set("n", "<leader>t", "<C-^>", { noremap = true, desc = "Toggle to alternate buffer" })

-- remove comment on newline
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- setup LSP-specific keybindings
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))
		vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
	end,
})

-- setup lazy.nvim
require("lazy").setup({
	spec = {
		{ -- colorscheme
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000, -- recommended for colorschemes
			opts = {
				transparent = true,
				style = "storm",
				styles = {
					floats = "transparent",
					sidebars = "transparent",
				},
			},
			config = function(_, opts)
				require("tokyonight").setup(opts)
				vim.cmd([[colorscheme tokyonight]])
			end,
		},

		{ -- lualine
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			opts = {},
		},

		{ -- file manager
			"stevearc/oil.nvim",
			lazy = false, -- lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
			dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional
			opts = {
				keymaps = {
					["_"] = false,
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
		},

		{ -- git
			{
				"lewis6991/gitsigns.nvim",
				opts = {
					signs = {
						add = { text = "+" },
						change = { text = "~" },
						delete = { text = "_" },
						topdelete = { text = "‾" },
						changedelete = { text = "~" },
					},
				},
			},
			{
				"NeogitOrg/neogit",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"sindrets/diffview.nvim", -- optional, diff integration
					"nvim-telescope/telescope.nvim", -- optional
				},
				opts = {},
				keys = {
					{
						"<leader>g",
						function()
							require("neogit").open()
						end,
						desc = "Open Neogit",
					},
				},
			},
		},

		{ -- treesitter
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
		},

		{ -- fuzzy finder
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-treesitter/nvim-treesitter",
			},
			keys = {
				{
					"<leader>ff",
					function()
						require("telescope.builtin").find_files()
					end,
					desc = "Find files",
				},
				{
					"<leader>fg",
					function()
						require("telescope.builtin").live_grep()
					end,
					desc = "Find by live grep",
				},
				{
					"<leader>fw",
					function()
						require("telescope.builtin").grep_string()
					end,
					desc = "Find word under cursor",
				},
			},
		},

		{ -- LSP
			{
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
				config = true,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = { "williamboman/mason.nvim" },
				event = { "BufReadPre", "BufNewFile" },
				opts = {
					ensure_installed = { "lua_ls" },
					automatic_installation = true,
				},
			},
			{
				"neovim/nvim-lspconfig",
				dependencies = {
					"williamboman/mason.nvim",
					"williamboman/mason-lspconfig.nvim",
				},
				event = { "BufReadPre", "BufNewFile" },
				config = function()
					local lspconfig = require("lspconfig")
					local mason_lspconfig = require("mason-lspconfig")

					mason_lspconfig.setup_handlers({
						function(server)
							lspconfig[server].setup({})
						end,
					})
				end,
			},
		},

		{ -- autocompletion
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
			},
			config = function()
				local cmp = require("cmp")
				local luasnip = require("luasnip")

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},

					mapping = cmp.mapping.preset.insert({
						-- one-key “smart Tab”: accept first item, otherwise fall back
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { "i", "s" }),

						["<Esc>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
					}),

					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					},

					experimental = { -- inline “ghost” suggestion
						ghost_text = { hl_group = "Comment" },
					},
				})

				-- let every LSP advertise cmp completion capability
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			end,
		},

		{ -- formatting
			{
				"stevearc/conform.nvim",
				dependencies = { "mason.nvim" },
				event = "BufWritePre", -- load just in time
				opts = {
					format_on_save = { timeout_ms = 500, lsp_fallback = true },
					formatters_by_ft = {
						lua = { "stylua" },
					},
				},
			},
			{ -- auto install formatters_by_ft
				"zapling/mason-conform.nvim",
				dependencies = {
					"williamboman/mason.nvim",
					"stevearc/conform.nvim",
				},
				opts = {},
			},
		},

		{ -- QoL
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
					},
				},
			},
			{ -- keymap hints
				"folke/which-key.nvim",
				event = "VeryLazy",
				opts = {},
				keys = {
					{
						"<leader>?",
						function()
							require("which-key").show({ global = false })
						end,
						desc = "Buffer Local Keymaps (which-key)",
					},
				},
			},
		},
	},
})
