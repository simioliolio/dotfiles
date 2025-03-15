return {
  "neovim/nvim-lspconfig",

  config = function()
    local lspconfig = require('lspconfig')
    -- TODO: import from config
    -- require 'config.lspconfig'

    -- local on_attach = config.on_attach
    -- local capabilities = config.capabilities

    -- lspconfig.ruff.setup{}

    lspconfig.pylsp.setup { -- Changed to pylsp.setup
      on_attach = function(client, bufnr)
        -- Optional: You can add keymaps here if you want LSP-specific keybindings
        -- for things like go-to-definition, rename, etc.
        -- Example keymaps (replace <leader> with your leader key):
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
      end,
    }

  end,
}
