return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    vim.keymap.set('n', '<Leader>ff', function() require("fzf-lua").files() end, { noremap = true, silent = true, desc = "FzfLua files"})
    vim.keymap.set('n', '<Leader>gg', function() require("fzf-lua").live_grep() end, { noremap = true, silent = true, desc = "FzfLua live_grep"})
    vim.keymap.set('n', '<Leader>bb', function() require("fzf-lua").buffers() end, { noremap = true, silent = true, desc = "FzfLua buffers"})
    vim.keymap.set('n', '<Leader>jj', function() require("fzf-lua").buffers() end, { noremap = true, silent = true, desc = "FzfLua jumps"})
    vim.keymap.set('n', '<Leader>gp', function ()
      local current_file_dir = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')
      if current_file_dir and current_file_dir ~= '' then
        require("fzf-lua").live_grep({
          cwd = current_file_dir,
        })
      else
        vim.notify('Not in a file buffer.')
      end
    end, { desc = "Grep in current file's directory" })
  end,
}
