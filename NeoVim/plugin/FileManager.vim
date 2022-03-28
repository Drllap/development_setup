command! -nargs=0 DCF call FileManager#DeleteCurrentFile()
command! -nargs=1 -complete=customlist,FileManager#RelativeFolderCompltions -bang MCF call FileManager#MoveCurrentFile(<q-args>, '<bang>')
command! -nargs=1 -complete=customlist,FileManager#RelativeFolderCompltions CNF call FileManager#CreateNewFile(<q-args>)

