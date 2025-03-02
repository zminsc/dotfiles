return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({
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
