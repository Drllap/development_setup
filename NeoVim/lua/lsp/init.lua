if(vim.env.LSP_Servers == nil) then
    error("The environmental variable with the LSP server path doesn't exist")
end

require('lsp.PowerShell')
