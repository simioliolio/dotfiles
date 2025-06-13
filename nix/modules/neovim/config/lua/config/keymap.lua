vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, bufopts)

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
