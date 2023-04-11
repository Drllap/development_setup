if vim.g.neovide then
  pcall(require, 'palli.neovide')
end
pcall(require,'lsp.init')
pcall(require,'auto-completion')
pcall(require,'nvim-dab-config')

pcall(require,'palli.treesitter')
pcall(require,'palli.telescope')
pcall(require,'palli.nvim-tree')
pcall(require,'palli.telescope-tabs')
pcall(require,'palli.lua-snip')
pcall(require,'palli.leap')

