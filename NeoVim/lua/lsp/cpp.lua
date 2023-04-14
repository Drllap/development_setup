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

require('lspconfig').clangd.setup({
  cmd = cmd()
})

