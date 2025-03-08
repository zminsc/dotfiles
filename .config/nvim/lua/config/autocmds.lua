-- Set indentation to 2
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua", "*.css" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Exit comment mode on enter or after hitting "o"/"O" in normal mode
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua" },
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})
