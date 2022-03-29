if has('win32')
  command! -nargs=0 SS call ShellSwitcher#Shell()
  silent call ShellSwitcher#Shell()  " default to PowerShell
endif

