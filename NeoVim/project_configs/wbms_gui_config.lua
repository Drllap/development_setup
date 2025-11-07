-- opts = { noremap = true, silent = true, expr = false };
vim.keymap.set('n', '<leader>tC', function() 
  local opts = { search_dirs = { "~/.config/Norbit"} }
  return require('telescope.builtin').find_files(opts)
end,
-- function() return require('telescope.builtin').find_files("~/AppData/Roaming/Norbit") end, 
{ noremap = true, silent = true, expr = false })


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

