function! SessionSaver#Save() abort
  let l:session_file =  getcwd() .. '/.session.vim'
  if filereadable(l:session_file)
    execute 'mksession! ' .. l:session_file
  endif
endfunction

function! SessionSaver#Restore() abort
  if filereadable(getcwd() .. '/.session.vim')
      execute 'source ' .. getcwd() .. '/.session.vim'
      if bufexists(1)
          for l in range(1, bufnr('$'))
              if bufwinnr(l) == -1
                  exec 'sbuffer ' .. l
              endif
          endfor
      endif
  endif
endfunction

