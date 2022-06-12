require('lsp.lua')
require('lsp.PowerShell')
require('lsp.python')
require('lsp.cmake')
require('lsp.vim')
require('lsp.cpp')

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

vim.keymap.set('n', '<leader><leader>c', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader><leader>C', vim.lsp.buf.outgoing_calls)

