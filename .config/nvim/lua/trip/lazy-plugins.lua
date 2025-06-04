require('lazy').setup {
  'NMAC427/guess-indent.nvim',

  require 'trip.plugins.telescope',

  require 'trip.plugins.lspconfig',

  require 'trip.plugins.conform',

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  require 'trip.plugins.blink-cmp',

  require 'trip.plugins.mini',

  require 'trip.plugins.treesitter',

  require 'trip.plugins.oil',

  require 'trip.plugins.colors',

  require 'trip.plugins.snacks',

  require 'trip.plugins.lua-line',

  require 'trip.plugins.vim-tmux',

  require 'trip.plugins.harpoon',
}
