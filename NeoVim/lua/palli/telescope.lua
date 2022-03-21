require('telescope').setup {}
require('telescope').load_extension('fzf')

-- Create keymap to browse the files in the current "project" (files under CWD)
local opts = { noremap = true, silent = true, expr = false };
local set_keymap = vim.api.nvim_set_keymap;
set_keymap('n', '<leader>tf', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts);
set_keymap('n', '<leader>tb', '<cmd>lua require("telescope.builtin").buffers({ sort_mru = true })<cr>', opts);
set_keymap('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts);
set_keymap('n', '<leader>tw', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts);
set_keymap('n', '<leader>ts', '<cmd>lua require("telescope.builtin").grep_string()<cr>', opts);

set_keymap('n', '<leader>tF', '<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true })<cr>', opts);

-- Create keymap to browse the vim config files with Telescope
local search_root = { cwd = vim.fn.fnamemodify(vim.fn.resolve(vim.env.MYVIMRC), ':h:h'), };
local no_new_line = { newline = ' ' };
local expression = string.format(
        '<cmd>lua require("telescope.builtin").find_files(%s)<cr>',
        vim.inspect(search_root, no_new_line));
set_keymap('n', '<leader>tc', expression, opts);

search_root = { cwd = vim.fn.stdpath('data') .. '\\plugged', };
expression = string.format(
        '<cmd>lua require("telescope.builtin").find_files(%s)<cr>',
        vim.inspect(search_root, no_new_line));
set_keymap('n', '<leader>tp', expression, opts);

