local M = {}

M.lua_lsp_root_path = function()
  return vim.env.LSP_Servers .. "/lua-language-server"
end

if "Linux" == vim.loop.os_uname().sysname then
  M.lua_lsp_binary = function()
    return M.lua_lsp_root_path() .. '/bin/lua-language-server'
  end
else
  M.lua_lsp_binary = function()
    return M.lua_lsp_root_path() .. '/bin/windows/lua-language-server'
  end
end

return M
