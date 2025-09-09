return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },
  config = function()
    local vim = vim
    local lspconfig = require("lspconfig")

    local jump_and_show_next = function()
      vim.diagnostic.jump({ count = 1, float = true })
    end

    local jump_and_show_previous = function()
      vim.diagnostic.jump({ count = -1, float = true })
    end

    local on_attach = function(client, bufnr)
      -- NOTE: We wrap this in a pcall to prevent errors if a server doesn't
      -- support formatting.
      local status_ok, _ = pcall(client.supports_method, "textDocument/formatting")
      if status_ok then
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', '<leader>K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<leader>fo', function() vim.lsp.buf.format { async = true } end, bufopts)
      vim.keymap.set('n', ']d', jump_and_show_next, bufopts)
      vim.keymap.set('n', '[d', jump_and_show_previous, bufopts)
    end

    local client_capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('blink-cmp').get_lsp_capabilities(client_capabilities)

    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              'lua/?.lua',
              'lua/?/init.lua',
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            }
          }
        }
      }
    })

    lspconfig.pylsp.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            black = { enabled = true },
            mypy = { enabled = true },
            yapf = { enabled = false },
          },
        },
      },
    })

    -- lspconfig.ruff.setup({
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- })

    lspconfig['kotlin_language_server'].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end,
}
