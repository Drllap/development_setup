local function cmd()
  vim.notify_once("The cmd function that supplies the clangd executable for the lsp hasn't been set", vim.log.levels.WARN);
  error("cmd not set")
end

if "Linux" == vim.loop.os_uname().sysname then
  cmd = function()
    return { "clangd-14" };
  end
else
  cmd = function()
    return { "clangd"};
  end
end

local root_files = {
  'compile_commands.json',
}

local util = require('lspconfig.util')

require('lspconfig').clangd.setup({
  cmd = cmd(),

  root_dir = function(fname)
    return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
  end,
  -- single_file_support = false,

  on_attach = function()
    vim.keymap.set('n', 'ssi', "<cmd>ClangdShowSymbolInfo<cr>",     { buffer = true, })
    vim.keymap.set('n', 'gh',  "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = true, })
  end,
})

