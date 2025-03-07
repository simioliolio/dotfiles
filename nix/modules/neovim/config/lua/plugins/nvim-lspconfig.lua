return {
  "neovim/nvim-lspconfig",

  config = function()
    local lspconfig = require('lspconfig')
    -- TODO: import from config
    -- require 'config.lspconfig'

    -- local on_attach = config.on_attach
    -- local capabilities = config.capabilities

    lspconfig.ruff.setup{}

  end,
}
