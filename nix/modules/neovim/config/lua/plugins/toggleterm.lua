return {
  'akinsho/toggleterm.nvim',
  config = function()
    local toggleterm = require('toggleterm')
    toggleterm.setup{
      size = function(term)
        local v_height_percentage = 0.75
        if term.direction == "horizontal" then
          -- vim.o.lines is the total height of the nvim window
          return math.floor(vim.o.lines * v_height_percentage)
        elseif term.direction == "vertical" then
          -- vim.o.columns is the total width of the nvim window
          return math.floor(vim.o.columns * 0.5)
        end
      end
    }
    vim.keymap.set('n', '<C-`>', '<cmd>ToggleTerm<cr>' )
    vim.keymap.set('t', '<C-`>', '<cmd>ToggleTerm<cr>' )

    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
    end
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  end
}
