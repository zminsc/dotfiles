return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup({})
    require("mason-lspconfig").setup({})

    local lspconfig = require("lspconfig")
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- Lua
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          workspace = {
            library = {
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.stdpath("config") .. "/lua",
              vim.fn.stdpath("data") .. "/lazy",
            },
            checkThirdParty = false,
          },
          diagnostics = {
            globals = { "vim", "LazyVim" },
          },
        },
      },
    })

    -- HTML & CSS
    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.emmet_language_server.setup({
      capabilities = capabilities,
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescriptreact" },
      init_options = {
        showSuggestionsAsSnippets = true,
      },
    })

    -- OCaml
    lspconfig.ocamllsp.setup({ capabilities = capabilities })
  end,
}
