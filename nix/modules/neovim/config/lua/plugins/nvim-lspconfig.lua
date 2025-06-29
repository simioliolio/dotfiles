return {
  "neovim/nvim-lspconfig",

  config = function()
    local jump_and_show_next = function()
      vim.diagnostic.jump({ count = 1, float = true })
    end
    local jump_and_show_previous = function()
      vim.diagnostic.jump({ count = -1, float = true })
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufopts = { noremap = true, silent = true, buffer = ev.buf }
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
    })

    vim.lsp.enable('lua_ls')
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
            return
          end
        end
        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
        })
      end,
      settings = {
        Lua = {}
      }
    })
    vim.lsp.enable('pylsp')
    vim.lsp.config('pylsp', {
      settings = {
        pylsp = {
          plugins = {
            mypy = {
              enabled = false
            }
          }
        }
      }

    })
    vim.lsp.enable('ruff')
    vim.lsp.enable("kotlin-language-server")
  end,
}
