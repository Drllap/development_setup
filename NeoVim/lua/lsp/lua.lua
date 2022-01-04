if not vim.env.LSP_Servers then
  print("The environmental variable with the LSP server path doesn't exist")
  print(debug.traceback())
  return
end

local sumneko_root_path = vim.env.LSP_Servers .. "/lua-language-server"
local sumneko_binary    = sumneko_root_path..'/bin/windows/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require('lspconfig').sumneko_lua.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path    = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
