return {
  'RRethy/vim-illuminate',
  config = function()
    require('illuminate').configure()
    local bufopts = { noremap = true, silent = true }
    vim.keymap.set('n', '[v', require('illuminate').goto_prev_reference, bufopts)
    vim.keymap.set('n', ']v', require('illuminate').goto_next_reference, bufopts)
  end
}
