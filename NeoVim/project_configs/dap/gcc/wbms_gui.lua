vim.print("aasdfasdfasdf")

return;

local dap = require("dap")
dap.configurations.cpp = {
  {
      name = "Launch",
      type = "gdb",
      request = "launch",
      program = function()
        local ret = vim.fn.getcwd() .. '/build/output/wbmsgui'
        vim.print("Starting gdb with: " .. ret)
        return ret
      end,
      args = {}, -- provide arguments if needed
      cwd = "${workspaceFolder}",
      stopAtBeginningOfMainSubprogram = false,
  },
}

