local opts = { noremap = true, silent = true, expr = false };
vim.api.nvim_set_keymap('n', '<leader>dd', "<cmd>lua require('dap').continue()<CR>",      opts);
vim.api.nvim_set_keymap('n', '<leader>dl', "<cmd>lua require('dap').run_last()<CR>",      opts);
vim.api.nvim_set_keymap('n', '<leader>dt', "<cmd>lua require('dap').terminate()<CR>",     opts);
vim.api.nvim_set_keymap('n', '<leader>ds', "<cmd>lua require('dap').step_over()<CR>",     opts);
vim.api.nvim_set_keymap('n', '<leader>di', "<cmd>lua require('dap').step_into()<CR>",     opts);
vim.api.nvim_set_keymap('n', '<leader>do', "<cmd>lua require('dap').step_out()<CR>",      opts);
vim.api.nvim_set_keymap('n', '<leader>dc', "<cmd>lua require('dap').run_to_cursor()<CR>", opts);
vim.api.nvim_set_keymap('n', '<leader>dB', "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts);
vim.api.nvim_set_keymap('n', '<leader>dL', "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts);
vim.api.nvim_set_keymap('n', '<leader>dr', "<cmd>lua require('dap').repl.toggle()<CR>",       opts);
vim.api.nvim_set_keymap('n', '<leader>db', "<cmd>lua require('dap').toggle_breakpoint()<CR>", opts);
vim.api.nvim_set_keymap('n', '<leader>dh', "<cmd>lua require('dap.ui.widgets').hover()<CR>",  opts);
vim.api.nvim_set_keymap('n', '<leader>dS', "<cmd>lua local w=require('dap.ui.widgets');w.cursor_float(w.scopes)<CR>", opts)
vim.api.nvim_set_keymap('n', '<leader>dF', "<cmd>lua local w=require('dap.ui.widgets');w.cursor_float(w.frames)<CR>", opts)

vim.api.nvim_command([[
autocmd FileType dap-repl lua require('dap.ext.autocompl').attach()
]]);

vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

pcall(require, 'palli.dap.python')
pcall(require, 'palli.dap.lldb')
