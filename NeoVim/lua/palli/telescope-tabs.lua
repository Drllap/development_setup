local ef = function(tab_id, buffer_ids, file_names, file_paths)
  return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab_id))
end

vim.keymap.set('n', '<leader>tt', function() require('telescope-tabs').list_tabs({ entry_formatter = ef}) end)

