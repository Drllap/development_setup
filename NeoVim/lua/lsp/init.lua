pcall(require,'lsp.lua_ls')
pcall(require,'lsp.PowerShell')
pcall(require,'lsp.python')
pcall(require,'lsp.cmake')
pcall(require,'lsp.vim')
pcall(require,'lsp.cpp')
pcall(require,'lsp.rust')
pcall(require,'lsp.sh')
pcall(require,'lsp.go')

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

