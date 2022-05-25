require('nvim-tree').setup{}

vim.keymap.set('n', '<C-k><C-b>', ":NvimTreeFocus<CR>", { silent = true, expr = false, } )
