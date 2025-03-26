-- Configure your Obsidian vault path here
local obsidian_vault_path = "~/obsidian"

-- Set indentation to 2
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.lua", "*.css", "*.js", "*.tsx" },
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

-- Disable line numbers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Obsidian-specific keymaps for markdown files within the vault
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    local file_path = vim.api.nvim_buf_get_name(buf)

    -- Expand the vault path to handle home directory (~) if present
    local expanded_vault_path = obsidian_vault_path:gsub("^~", vim.fn.expand("$HOME"))

    -- Check if file is within Obsidian vault
    if file_path:match("%.md$") and file_path:find(expanded_vault_path, 1, true) then
      -- <leader>sf for quick switching between files
      vim.keymap.set("n", "<leader>sf", function() vim.cmd("ObsidianQuickSwitch") end,
      { buffer = buf, desc = "[S]witch Obsidian [F]iles" })

      -- <leader>sp for searching in the vault
      vim.keymap.set("n", "<leader>sp", function() vim.cmd("ObsidianSearch") end,
      { buffer = buf, desc = "[S]earch Obsidian [P]roject" })
    end
  end
})
