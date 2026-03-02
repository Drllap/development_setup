require('telescope').load_extension('telescope-tabs')

local list_cwds = function(tab_id, buffer_ids, file_names, file_paths)
  return vim.fn.getcwd(-1, vim.api.nvim_tabpage_get_number(tab_id))
end

local config = { entry_formatter = list_cwds, entry_ordinal = order }
-- local time_map = {};
-- vim.api.nvim_create_autocmd(
--   "TabEnter",
--   { group = vim.api.nvim_create_augroup("telescope-tabs", { clear = true }),
--     callback = function()
--       print(string.format('event fired'))
--       time_map[vim.api.nvim_tabpage_get_number(0)] = vim.fn.localtime()
--     end,
--     desc = "Update the timestamp map that controls the order of the tabs"
--   }
-- )

-- local order = function(tab_id, buffer_ids, file_names, file_paths)
  -- print(vim.inspect(time_map))
  -- local ts = time_map[tab_id]
  -- if ts then
    -- return tostring(-ts)
  -- end
  -- return tostring(-vim.fn.localtime())
-- end
-- local config = { entry_formatter = list_cwds, entry_ordinal = order }

vim.keymap.set('n', '<leader>tt', function() require('telescope-tabs').list_tabs(config) end)
vim.keymap.set('n', '<leader>pt', function() require('telescope-tabs').go_to_previous()  end);

