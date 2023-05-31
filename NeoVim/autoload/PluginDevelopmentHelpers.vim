function! PluginDevelopmentHelpers#ToggleCWDInRuntimePath() abort
  let list = split(&runtimepath, ',')
  let idx = list->index(getcwd())
  if idx >= 0
    call remove(list, idx)
    let &runtimepath = list->join(',')
    echo "CWD removed from runtime path"
  else
    let &runtimepath.=','..getcwd()
    echo "CWD added to runtime path"
  endif
endfunction

