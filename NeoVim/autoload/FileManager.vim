function! FileManager#DeleteCurrentFile() abort
  echo "Deleting File " expand('%')
  call delete(expand('%'))
endfunction

let s:seperator = '/'
if has('win32')
  let s:seperator = '\'
endif

function! FileManager#MoveCurrentFile(filename, bang) abort
  let l:new_file_path = s:file_path_cleanup(a:filename)
  if isdirectory(l:new_file_path)
    let l:new_file_path = l:new_file_path .. s:seperator .. expand('%:t') 
  endif
  if a:bang == "!"
    let l:old_file = expand('%')
    execute 'saveas! ' .. a:filename
    call delete(l:old_file)
    return
  endif
  if filereadable(l:new_file_path)
    echomsg "File already exist " l:new_file_path
    return
  elseif bufexists(l:new_file_path)
    echomsg "Unsaved buffer with name already exists " l:new_file_path
    return
  endif

  let l:old_file = expand('%')
  execute 'saveas ' .. l:new_file_path
  call delete(l:old_file)
endfunction

function! s:file_path_cleanup(filename) abort
  let l:new_file_path = expand('%:h') .. s:seperator .. a:filename
  let l:new_file_path = fnameescape(l:new_file_path)
  let l:new_file_path = fnamemodify(l:new_file_path, ':.')
  return l:new_file_path
endfunction

function! FileManager#CreateNewFile(filename) abort
  let l:new_file_path = s:file_path_cleanup(a:filename)

  if filereadable(l:new_file_path)
    echo "File already exist " l:new_file_path
  elseif bufexists(l:new_file_path)
    echo "Buffer with name already exists " l:new_file_path
  else
    echo "New File Created " l:new_file_path
  endif
  execute "edit " .. fnameescape(l:new_file_path)
endfunction

let s:DEBUG = v:false

function! FileManager#RelativeFolderCompltions(ArgLead, CmdLine, CursorPos) abort
  let l:search_folder = expand('%:h') .. s:seperator
  let l:search_path = l:search_folder .. a:ArgLead .. '*'
  let l:glob = glob(l:search_path, v:false, v:true)
  let l:filtered = filter(l:glob, 'isdirectory(v:val)')
  let l:mapped = map(l:filtered, {_, val -> val[len(l:search_folder):] .. s:seperator}) 

  if s:DEBUG 
    messages clear
    echomsg "ArgLead " a:ArgLead
    echomsg "expanded " expand('%:h')
    echomsg "Search path: " l:search_path
    echomsg "Search Folder" l:search_folder
    echomsg "Glob: " l:glob
    echomsg "Filtered: " l:filtered
    echomsg "Mapped: " l:mapped
  endif
  return l:mapped
endfunction


