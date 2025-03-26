-- plugins/telescope.lua:
return {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  lazy = false,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  },
}
