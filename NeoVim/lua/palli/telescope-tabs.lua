local list_cwds = function(tab_id, buffer_ids, file_names, file_paths)
  return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab_id))
end

local list_cwds = function(tab_id, buffer_ids, file_names, file_paths)
  return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab_id))
end

local config = { entry_formatter = list_cwds, entry_ordinal = list_cwds }

vim.keymap.set('n', '<leader>tt', function() require('telescope-tabs').list_tabs(config) end)
vim.keymap.set('n', '<leader>pt', function() require('telescope-tabs').go_to_previous() end);

