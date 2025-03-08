-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Oil
vim.keymap.set("n", "-", function() require("oil").open_float(vim.fn.expand("%:p:h")) end, { desc = "Open current file directory" })

-- Movement 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")


-- HACK: if a plugin isn't loaded yet, wrap the require("<plugin_name>") call in function()

-- Telescope (prefix: <leader>s for "[S]earch")
vim.keymap.set('n', '<leader>sf', function() require("telescope.builtin").find_files() end, { desc = "[S]earch [F]iles}" })
vim.keymap.set('n', '<leader>sp', function() require("telescope.builtin").live_grep() end, { desc = "[S]earch [P]roject}" })
vim.keymap.set('n', '<leader>sb', function() require("telescope.builtin").buffers() end, { desc = "[S]earch [B]uffers}" })
vim.keymap.set('n', '<leader>sh', function() require("telescope.builtin").help_tags() end, { desc = "[S]earch [H]elp}" })

-- nvim-cmp
vim.keymap.set("i", "<C-n>", function() require("cmp").select_next_item({ behavior = require("cmp").SelectBehavior.Select }) end)
vim.keymap.set("i", "<C-p>", function() require("cmp").select_prev_item({ behavior = require("cmp").SelectBehavior.Select }) end)

vim.keymap.set("i", "<C-CR>", function() require("cmp").confirm({ select = true }) end)
vim.keymap.set("i", "<Tab>", function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  if cmp.visible() then
    cmp.confirm({ select = true })
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
  end
end)


