require('telescope').setup {}

-- Create keymap to browse the files in the current "project" (files under CWD)
local opts = { noremap = true, silent = true, expr = false };
local set_keymap = vim.api.nvim_set_keymap;
set_keymap('n', '<leader>f',  '<cmd>lua require("telescope.builtin").find_files()<cr>', opts);
set_keymap('n', '<leader>F',  '<cmd>lua require("telescope.builtin").find_files({ hidden = true, no_ignore = true, follow = true })<cr>', opts);
vim.keymap.set('n', '<leader>tb',
  function() require("telescope.builtin").buffers({ sort_mru = true, only_cwd = true, ignore_current_buffer = true}) end, opts);
vim.keymap.set('n', '<leader>tB',
  function() require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true}) end, opts);

vim.keymap.set('n', '<leader>th', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts);
vim.keymap.set('n', '<leader>tw', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts);
vim.keymap.set('n', '<leader>tW', '<cmd>lua require("telescope.builtin").live_grep({additional_args = {"--hidden"} })<cr>', opts);
vim.keymap.set('n', '<leader>ts', '<cmd>lua require("telescope.builtin").grep_string()<cr>', opts);
vim.keymap.set('n', '<leader>tS', '<cmd>lua require("telescope.builtin").grep_string({additional_args = {"--hidden"} })<cr>', opts);

vim.keymap.set('n', '<leader>;',  require('telescope.builtin').current_buffer_fuzzy_find, opts);
vim.keymap.set('n', '<leader>tr', require('telescope.builtin').resume, opts);

vim.keymap.set('n', '<leader>tgc',  require('telescope.builtin').git_commits, opts);
vim.keymap.set('n', '<leader>tgbc', require('telescope.builtin').git_bcommits, opts);
vim.keymap.set('n', '<leader>tgbr', require('telescope.builtin').git_branches, opts);
vim.keymap.set('n', '<leader>tgs',  require('telescope.builtin').git_status, opts);
vim.keymap.set('n', '<leader>tgt',  require('telescope.builtin').git_stash, opts);

vim.keymap.set('n', '<leader>tm', require('telescope.builtin').marks, opts);
vim.keymap.set('n', '<leader>tR', require('telescope.builtin').registers, opts);

vim.keymap.set('n', '<leader>tld', require('telescope.builtin').lsp_definitions, opts);
vim.keymap.set('n', '<leader>tlt', require('telescope.builtin').lsp_type_definitions, opts);
vim.keymap.set('n', '<leader>tli', require('telescope.builtin').lsp_implementations, opts);
vim.keymap.set('n', '<leader>tlr', require('telescope.builtin').lsp_references, opts);
vim.keymap.set('n', '<leader>s',   require('telescope.builtin').lsp_document_symbols, opts);
vim.keymap.set('n', '<leader>S',   require('telescope.builtin').lsp_workspace_symbols, opts);
vim.keymap.set('n', '<leader>tle', require('telescope.builtin').diagnostics, opts);

-- Create keymap to browse the vim config files with Telescope
local vim_config_root = {
  cwd = vim.fn.fnamemodify(vim.fn.resolve(vim.env.MYVIMRC), ':h:h'),
  hidden = true,
  no_ignore = true,
};
vim.keymap.set('n', '<leader>tc', function() return require('telescope.builtin').find_files(vim_config_root) end, opts);

-- Create keymap to browse the vim pluggins files with Telescope
local pluggins_root = { cwd = vim.fn.stdpath('data') .. '\\plugged', };
vim.keymap.set('n', '<leader>tp', function() return require('telescope.builtin').find_files(pluggins_root) end, opts);
