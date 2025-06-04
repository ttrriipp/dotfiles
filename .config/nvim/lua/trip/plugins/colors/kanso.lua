return {
  'webhooked/kanso.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('kanso').setup {
      italics = false,
      transparent = true,
      colors = {
        pallete = {
          fujiWhite = '#DCD7BA',
        },
      },
      theme = 'zen',
      background = {
        dark = 'zen',
        light = 'pearl',
      },
    }

    vim.cmd.colorscheme 'kanso'
  end,
}
