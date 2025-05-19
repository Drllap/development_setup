if not vim.env.LSP_Servers then
  print("The environmental variable with the LSP server path doesn't exist")
  print(debug.traceback())
  return
end

require('lspconfig').powershell_es.setup {
    bundle_path = vim.env.LSP_Servers .. "PowerShellEditorServices",
    shell = "pwsh",
}
