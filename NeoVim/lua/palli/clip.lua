if os.getenv("WSL_DISTRO_NAME") == nil then
  return
end
vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
        ['+'] = '/mnt/c/Users/pallp/scoop/shims/win32yank.exe -i --crlf',
        ['*'] = '/mnt/c/Users/pallp/scoop/shims/win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = '/mnt/c/Users/pallp/scoop/shims/win32yank.exe -o --lf',
        ['*'] = '/mnt/c/Users/pallp/scoop/shims/win32yank.exe -o --lf',
    },
    cache_enabled = 0,
}
vim.opt.clipboard = 'unnamedplus'

