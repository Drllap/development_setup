return function()
  local mods = ""
  -- NOTE: by default vim.keymap.set uses noremap, contrary to the :map command
  -- vim.keymap.set(mods, "*",   "<Plug>(asterisk-*)")
  -- vim.keymap.set(mods, "#",   "<Plug>(asterisk-#)")
  vim.keymap.set(mods, "g*",  "<Plug>(asterisk-g*)")
  vim.keymap.set(mods, "g#",  "<Plug>(asterisk-g#)")
  vim.keymap.set(mods, "*",   "<Plug>(asterisk-z*)")
  -- vim.keymap.set(mods, "gz*", "<Plug>(asterisk-gz*)")
  vim.keymap.set(mods, "#",   "<Plug>(asterisk-z#)")
  -- vim.keymap.set(mods, "gz#", "<Plug>(asterisk-gz#)")
  vim.cmd([[let g:asterisk#keeppos = 1]])
end
