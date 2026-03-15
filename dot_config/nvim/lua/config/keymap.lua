vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts) -- Open floating window with diagnotics details
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, bufopts) -- Open diagnostics in a location list

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.keymap.set('n', '<leader>s', ':set spell!<CR>', {
  noremap = true,
  silent = true,
  desc = "Toggle spell check"
})
