return { -- formatting
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
}
