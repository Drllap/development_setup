local M = {}

local utils = require('lsp.lua.utils')

local check_has_server = function()
  return 1 == vim.fn.executable(utils.lua_lsp_binary())
end

local lsp_srv_env_var_set = function()
  return nil ~= vim.env.LSP_Servers
end

M.check = function()
  vim.health.report_start("Lua LSP report")

  if lsp_srv_env_var_set() then
    vim.health.report_ok("LSP_Servers environmental variable set: " .. vim.env.LSP_Servers)
  else
    vim.health.report_error("environmental variable 'LSP_Servers' not set")
  end

  if check_has_server() then
    vim.health.report_ok("Lua LSP server executable found at: " .. utils.lua_lsp_binary())
  else
    vim.health.report_error("Lua LSP server executable not found, was supposed to be at: " .. utils.lua_lsp_binary())
  end
end

return M
