require('nvim-window').setup({})

vim.keymap.set('n', '<leader>W', function() require('nvim-window').pick() end)

