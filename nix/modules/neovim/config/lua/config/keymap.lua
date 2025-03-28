vim.keymap.set("n", "<Leader>ll", function() require("lint").try_lint() end, { desc = "Lint current file" })

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
