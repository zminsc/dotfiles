return {
  "neovim/nvim-lspconfig",
  config = function()
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
  end,
}
