-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Oil
vim.keymap.set("n", "-", function() require("oil").open_float(vim.fn.expand("%:p:h")) end, { desc = "Open current file directory" })

-- Movement 
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Telescope (prefix: <leader>s for "[S]earch")

-- HACK: telescope isn't loaded yet, so wrap the require("...") call in function()
vim.keymap.set('n', '<leader>sf', function() require("telescope.builtin").find_files() end, { desc = "[S]earch [F]iles}" })
vim.keymap.set('n', '<leader>sp', function() require("telescope.builtin").live_grep() end, { desc = "[S]earch [P]roject}" })
vim.keymap.set('n', '<leader>sb', function() require("telescope.builtin").buffers() end, { desc = "[S]earch [B]uffers}" })
vim.keymap.set('n', '<leader>sh', function() require("telescope.builtin").help_tags() end, { desc = "[S]earch [H]elp}" })
