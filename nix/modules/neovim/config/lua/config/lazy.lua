local vim = vim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Tab configuration
vim.o.tabstop = 2 -- A TAB character looks like 2 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting

-- Setup clipboard
vim.o.clipboard = "unnamed" -- OSX

-- Line numbers
vim.o.number = true

-- Spelling
vim.opt.spell = true
vim.opt.spelllang = "en_gb"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- colorscheme that will be used when installing plugins.
  install = {
    colorscheme = { "catppuccin" }
  },

  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Brighten up Visual to be as bright as IncSearch
local function copy_highlight_style(source_group, target_group)
  local source_attrs = vim.api.nvim_get_hl(0, { name = source_group })
  if not source_attrs then
    vim.api.nvim_echo({
      { source_group, " highlight not found"}
    }, true, {})
    os.exit(1)
  end
  vim.api.nvim_set_hl(0, target_group, {
    bg = source_attrs.bg,
    fg = source_attrs.fg,
  })
end
copy_highlight_style('IncSearch', 'Visual')
