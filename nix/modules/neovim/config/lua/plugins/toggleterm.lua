return {
  'akinsho/toggleterm.nvim',
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup{}
    vim.keymap.set('n', '<C-`>', '<cmd>ToggleTerm<cr>' )
    vim.keymap.set('t', '<C-`>', '<cmd>ToggleTerm<cr>' )

  end
}
