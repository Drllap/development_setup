require('lsp.lua')
require('lsp.PowerShell')
require('lsp.python')
require('lsp.cmake')
require('lsp.vim')
require('lsp.cpp')

vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>cA', vim.lsp.buf.code_action)

vim.keymap.set('n', '<leader>ch', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>cK', vim.lsp.buf.hover)

vim.keymap.set('n', '<leader>cd', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>cD', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>ct', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>ci', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>cr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>cs', vim.lsp.buf.document_symbol)
vim.keymap.set('n', '<leader>cS', vim.lsp.buf.workspace_symbol)

vim.keymap.set('n', '<leader>cc', vim.lsp.buf.incoming_calls)
vim.keymap.set('n', '<leader>cC', vim.lsp.buf.outgoing_calls)


