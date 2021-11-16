if not vim.env.LSP_Servers then
    error("The environmental variable with the LSP server path doesn't exist")
end

require('lsp.lua')
require('lsp.PowerShell')
require('lsp.python')
