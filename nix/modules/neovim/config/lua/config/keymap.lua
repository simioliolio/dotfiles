vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, bufopts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, bufopts)

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
