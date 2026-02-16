compiler! msbuild

noremap <leader>b :silent! :wall <bar>
                \ :execute ":Make "             .. '*.sln'->globpath('./build/')<CR>

noremap <leader>B :silent! :wall <bar>
                \ :execute ":Dispatch msbuild " .. '*.sln'->globpath('./build/')<CR>
