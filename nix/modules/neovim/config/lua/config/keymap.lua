vim.keymap.set('n', '<Leader>ff', function() require("fzf-lua").files() end, { noremap = true, silent = true, desc = "FzfLua files"})

vim.keymap.set('n', '<Leader>gg', function() require("fzf-lua").grep_project() end, { noremap = true, silent = true, desc = "FzfLua grep_project"})

vim.keymap.set('n', '<Leader>bb', function() require("fzf-lua").buffers() end, { noremap = true, silent = true, desc = "FzfLua buffers"})

vim.keymap.set("n", "<Leader>ll", function() require("lint").try_lint() end, { desc = "Lint current file" })

vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand("%")
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
