vim.keymap.set('n', '<Leader>ff', function() require("fzf-lua").files() end, { noremap = true, silent = true, desc = "FzfLua files"})

vim.keymap.set('n', '<Leader>gg', function() require("fzf-lua").grep_project() end, { noremap = true, silent = true, desc = "FzfLua grep_project"})

vim.keymap.set("n", "<Leader>ll", function() require("lint").try_lint() end, { desc = "Lint current file" })

