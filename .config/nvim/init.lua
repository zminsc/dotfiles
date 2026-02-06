-- MUST be set before setting up lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- setup lazy.nvim
require("lazy").setup({
	spec = {
		{ -- Dracula theme
			"Mofiqul/dracula.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("dracula").setup({
					transparent_bg = true,
				})
				vim.cmd([[colorscheme dracula]])
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
		},

		{ -- treesitter
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			opts = {
				ensure_installed = { "lua", "vim" },
				auto_install = true,
			},
			config = function(_, opts)
				require("nvim-treesitter.configs").setup(opts)
			end,
		},

		{ -- markdown rendering
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
			config = function(_, opts)
				vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { bg = "#24273A", fg = "#8AADF4" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { bg = "#2C282C", fg = "#E5C890" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { bg = "#2A322F", fg = "#A6DA95" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { bg = "#1C2930", fg = "#8BD5CA" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { bg = "#2B2738", fg = "#C6A0F6" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { bg = "#292739", fg = "#B7A1F4" })

				vim.api.nvim_set_hl(0, "RenderMarkdownH1", { fg = "#8AADF4" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH2", { fg = "#E5C890" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH3", { fg = "#A6DA95" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH4", { fg = "#8BD5CA" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH5", { fg = "#C6A0F6" })
				vim.api.nvim_set_hl(0, "RenderMarkdownH6", { fg = "#B7A1F4" })

				require("render-markdown").setup(opts)
			end,
			opts = {
				heading = {
					sign = false,
					position = "inline",
				},
				render_modes = true,
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
					local capabilities = require("cmp_nvim_lsp").default_capabilities()

					mason_lspconfig.setup_handlers({
						function(server)
							lspconfig[server].setup({
								capabilities = capabilities,
							})
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
						cpp = { "clang_format" },
						python = { "ruff" },
						rust = { "rustfmt" },
						systemverilog = { "verible" },
						markdown = { "prettier" },
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
		},
	},
})
