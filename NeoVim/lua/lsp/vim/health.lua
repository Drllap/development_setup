local M = {}

M.check = function()
  vim.health.report_start("Vim LSP report")

  if 1 == vim.fn.executable("vim-language-server") then
    vim.health.report_ok("Found vim-language-server")
  else
    vim.health.report_error("Can't find vim-language-server executable. Install with `npm install -g vim-language-server`")
  end
end
return M
