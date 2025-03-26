local obsidian_vault_path = "~/obsidian"

return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "default",
        path = obsidian_vault_path,
      },
      {
        name = "eli5",
        path = obsidian_vault_path,
        overrides = {
          notes_subdir = "eli5",
        },
      },
    },
    notes_subdir = "zettelkasten",
    log_level = vim.log.levels.ERROR,
    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },
    new_notes_location = "notes_subdir",
    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
    end,
    disable_frontmatter = true,
    templates = {
      folder = "templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {},
    },
    open_app_foreground = true,
    picker = {
      name = "telescope.nvim",
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-CR>",
        -- Insert a link to the selected note.
        insert_link = "<C-i>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        -- tag_note = "<C-x>",
        -- Insert a tag at the current location.
        -- insert_tag = "<C-l>",
      },
    },
  },
  config = function(_, opts)
    -- Load the plugin with the options
    require("obsidian").setup(opts)

    -- Create autocommand for Obsidian-specific keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        local file_path = vim.api.nvim_buf_get_name(buf)

        -- Expand the vault path to handle home directory (~) if present
        local expanded_vault_path = obsidian_vault_path:gsub("^~", vim.fn.expand("$HOME"))

        -- Check if file is within Obsidian vault
        if file_path:match("%.md$") and file_path:find(expanded_vault_path, 1, true) then
          -- Set conceallevel to 2 to render pretty todos
          vim.opt_local.conceallevel = 2

          -- Normal mode mappings
          vim.keymap.set("n", "<leader>oo", function() vim.cmd("ObsidianOpen") end,
          { buffer = buf, desc = ":[O]bsidian[O]pen" })
          vim.keymap.set("n", "<leader>on", function() vim.cmd("ObsidianNew") end,
          { buffer = buf, desc = ":[O]bsidian[N]ew" })
          vim.keymap.set("n", "<leader>ot", function() vim.cmd("ObsidianTemplate") end,
          { buffer = buf, desc = ":[O]bsidian[T]emplate" })
          vim.keymap.set("n", "<leader>ob", function() vim.cmd("ObsidianBacklinks") end,
          { buffer = buf, desc = ":[O]bsidian[B]acklinks" })
          vim.keymap.set("n", "<leader>ol", function() vim.cmd("ObsidianFollowLink") end,
          { buffer = buf, desc = ":[O]bsidianFollow[L]ink" })
          vim.keymap.set("n", "<leader>ow", function() vim.cmd("ObsidianWorkspace") end,
          { buffer = buf, desc = "[O]bsidian[W]orkspace" })
          vim.keymap.set("n", "<leader>of", function() vim.cmd("ObsidianQuickSwitch") end,
          { buffer = buf, desc = "[O]bsidian Search [F]iles" })
          vim.keymap.set("n", "<leader>op", function() vim.cmd("ObsidianSearch") end,
          { buffer = buf, desc = "[O]bsidian Search [P]roject" })
        end
      end,
    })
  end,
}
