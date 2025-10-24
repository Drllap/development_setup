-- pcall(require,'lsp.PowerShell')
-- pcall(require,'lsp.cpp')

local original = vim.lsp.config.clangd
vim.lsp.config('clangd', {
  cmd = {
    'clangd',
    '--background-index',
    '--background-index-priority=low',
    '--clang-tidy',
    '--header-insertion=never',
    '--function-arg-placeholders',
    '--log=verbose',
    '--completion-style=detailed',
    '--fallback-style=llvm',
    -- '--log=verbose' ,
  },
  on_attach = function(client, bufnr)
    original.on_attach(client, bufnr)
    vim.keymap.set('n', 'ssi', "<cmd>LspClangdShowSymbolInfo<cr>",     { buffer = true, })
    vim.keymap.set('n', 'gh',  "<cmd>LspClangdSwitchSourceHeader<cr>", { buffer = true, })
  end,
})

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
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})

vim.lsp.config('cspell_ls', {
    filetypes = {"go", "rust", "js", "ts", "html", "css", "json", "yaml", "markdown", "gitcommit", "cpp", "c" },
})

vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  }
})

vim.lsp.enable({
  'clangd', 'cmake',
  'pyright', 'rust_analyzer', 'zls', 'gopls',
  'vimls', 'lua_ls',
  'cspell_ls', 'harper_ls',
  'bashls', 'nushell',
  'yamlls',
})

vim.keymap.set('n', '<leader><leader>R', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader><leader>A', vim.lsp.buf.code_action)

vim.keymap.set('n', '<leader><leader>h', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader><leader>K', vim.lsp.buf.hover)

vim.keymap.set('n', '<leader><leader>D', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader><leader>d', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader><leader>t', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader><leader>i', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader><leader>r', vim.lsp.buf.references)
vim.keymap.set('n', '<leader><leader>s', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader><leader>S', vim.lsp.buf.workspace_symbol)

vim.keymap.set('n', '<leader><leader>ic', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader><leader>oc', vim.lsp.buf.outgoing_calls)

vim.diagnostic.config({
  virtual_text = false,
  float = {
    show_header = true,
    source = 'if_many',
    border = 'rounded',
    focusable = true,
  },
})

vim.keymap.set('n', '<leader>DD', vim.diagnostic.open_float)
vim.keymap.set('i', '<C-S>', vim.lsp.buf.signature_help)

--   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

