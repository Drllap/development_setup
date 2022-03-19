if has('win32')
  command! -nargs=0 SS call ShellSwitcher#Shell()
  call ShellSwitcher#Shell()  " default to PowerShell
endif

