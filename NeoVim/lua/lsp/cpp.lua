local function cmd()
  if "Linux" == vim.loop.os_uname().sysname then
    return { "clangd-12" };
  else
    return { "clangd"};
  end
end

require('lspconfig').clangd.setup({
  cmd = cmd()
})
