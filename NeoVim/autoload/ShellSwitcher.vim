function! ShellSwitcher#Shell() abort
  if &shell == "cmd.exe"
    let &shell = 'powershell -NoLogo'
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote =
    set shellxquote =
    echo "Switching to PowerShell"
  else
    set shell&
    set shellcmdflag&
    set shellredir&
    set shellpipe&
    set shellquote&
    set shellxquote&
    echo "Switching to cmd.exe"
  endif
endfunction

