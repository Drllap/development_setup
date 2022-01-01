require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

-- require('telescope').load_extension('fzf')

-- Create keymap to browse the files in the current "project" (files under CWD)
local opts = { noremap = true, silent = true, expr = false };
local set_keymap = vim.api.nvim_set_keymap;
set_keymap('n', '<leader>tf', '<cmd>lua require("telescope.builtin").find_files()<cr>', opts);
set_keymap('n', '<leader>tb', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts);
set_keymap('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts);
set_keymap('n', '<leader>tw', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts);

-- Create keymap to browse the vim config files with Telescope
local search_root = { cwd = vim.fn.fnamemodify(vim.env.MYVIMRC, ':h'), };
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

