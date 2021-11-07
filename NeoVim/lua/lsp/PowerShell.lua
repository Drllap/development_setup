require('lspconfig').powershell_es.setup {
    bundle_path = vim.env.LSP_Servers .. "PowerShellEditorServices",
    shell = "powershell",
}
