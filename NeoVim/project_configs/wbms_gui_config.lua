vim.keymap.set('n', '<leader>tC', function() 
    local opts = { search_dirs = { "~/AppData/Roaming/Norbit"} }
    return require('telescope.builtin').find_files(opts)
  end,
  { noremap = true, silent = true, expr = false }
)
-- function() return require('telescope.builtin').find_files("~/AppData/Roaming/Norbit") end, 

if 1 == vim.fn.has("linux") then
  vim.keymap.set('n', '<leader>tC', function() 
    local opts = { search_dirs = { "~/.config/Norbit"} }
    return require('telescope.builtin').find_files(opts)
  end,
  { noremap = true, silent = true, expr = false })
  vim.cmd("runtime project_configs/dap/gcc/wbms_gui.lua")
end

vim.api.nvim_create_user_command('Setup', function()
  vim.cmd(":runtime project_configs/setup/wbms_gui.vim")
end, { bang = true})

vim.cmd(":runtime project_configs/compilers/msb.vim")
