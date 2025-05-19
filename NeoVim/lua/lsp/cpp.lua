local function cmd()
  return {
    'clangd',
    '--background-index',
    '--background-index-priority=low',
    '--clang-tidy',
    '--header-insertion=never',
    '--function-arg-placeholders',
    '--log=verbose',
    '--completion-style=detailed',
    '--fallback-style=llvm',
  }
end

local root_files = {
  'compile_commands.json',
}

local util = require('lspconfig.util')

require('lspconfig').clangd.setup({
  cmd = cmd(),

  root_dir = function(fname)
    local asdf = util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    vim.print(asdf)
    return asdf
  end,

  init_options = {
    fallback_flags = { '-std=c++23' },
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },

  -- single_file_support = false,

  on_attach = function()
    vim.keymap.set('n', 'ssi', "<cmd>ClangdShowSymbolInfo<cr>",     { buffer = true, })
    vim.keymap.set('n', 'gh',  "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true, })
  end,
})

