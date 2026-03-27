return { -- markdown rendering
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

		vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#D9D9D9" })
		vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#37FD12" })
		vim.api.nvim_set_hl(0, "RenderMarkdownCheckboxMigrate", { fg = "#E5C890" })
		vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#ED8796" })

		require("render-markdown").setup(opts)
	end,
	opts = {
		heading = {
			sign = false,
			position = "inline",
		},
		checkbox = {
			custom = {
				in_progress = { raw = "[>]", rendered = "󰛂 ", highlight = "RenderMarkdownCheckboxMigrate" },
				todo = { raw = "[-]", rendered = " ", highlight = "RenderMarkdownTodo" },
			},
		},
		render_modes = true,
	},
}
