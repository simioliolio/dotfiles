return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    vim.keymap.set('n', '<Leader>ff', function() require("fzf-lua").files() end, { noremap = true, silent = true, desc = "FzfLua files"})
    vim.keymap.set('n', '<Leader>gg', function() require("fzf-lua").live_grep({ search = vim.fn.expand("")}) end, { noremap = true, silent = true, desc = "FzfLua live_grep"})
    vim.keymap.set('n', '<Leader>gc', function() require("fzf-lua").live_grep({ search = vim.fn.expand("<cword>")}) end, { noremap = true, silent = true, desc = "FzfLua live_grep of word under cursor"})
    vim.keymap.set('n', '<Leader>gh', function() require("fzf-lua").live_grep({ rg_opts = "--hidden --no-ignore" }) end, {
      noremap = true,
      silent = true,
      desc = "FzfLua live_grep including hidden files"
    })
    vim.keymap.set('n', '<Leader>bb', function() require("fzf-lua").buffers() end, { noremap = true, silent = true, desc = "FzfLua buffers"})
    vim.keymap.set('n', '<Leader>jj', function() require("fzf-lua").jumps() end, { noremap = true, silent = true, desc = "FzfLua jumps"})
    vim.keymap.set('n', '<Leader>kk', function() require("fzf-lua").keymaps() end, { noremap = true, silent = true, desc = "FzfLua keymaps"})
    vim.keymap.set('n', '<Leader>gp', function ()
      local current_file_dir = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')
      if current_file_dir and current_file_dir ~= '' then
        require("fzf-lua").live_grep({
          cwd = current_file_dir,
          prompt = 'Live grep in ' .. current_file_dir .. '>',
        })
      else
        vim.notify('Not in a file buffer.')
      end
    end, { desc = "Grep in current file's directory" })
    vim.keymap.set('n', '<Leader>g/', function ()
      local last_search_term = vim.fn.getreg('/')
      if last_search_term == '' then
        vim.notify("No current search term found", vim.log.levels.INFO, { title = "fzf-lua g/" })
      end
      require("fzf-lua").live_grep({
        query = last_search_term,
        case_mode = 'respect_case',
      })
    end)
    require("fzf-lua").setup({
      winopts = { preview = { wrap = true, layout = "horizonal" }},
      fzf_opts = {
        ['--bind'] = 'ctrl-c:clear-query', -- clear the input
      },
    })
  end,
}
