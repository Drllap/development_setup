echo "ninja"
compiler! gcc
set makeprg=ninja
" noremap <leader>b :silent! :wall <bar> :execute ':Make ' .. '*.sln'->globpath('../build/')<CR>
noremap <leader>b :silent! :wall <bar> :Dispatch -dir=./build/Debug/<CR>
noremap <leader>B :silent! :wall <bar> :Dispatch -dir=./build/Debug/ -- -k 0<CR>
command! -nargs=0 CMake !cmake -G Ninja -S ./src/ -B ./build/ -DCMAKE_MODULE_PATH=${PWD}/build/ -DBUILD_TESTING=ON -DCMAKE_BUILD_TYPE=Debug
if !filereadable(expand("./src/compile_commands.json"))
  " This takes to long
  :silent! !ln --symbolic --force ../build/Debug/compile_commands.json ./src/compile_commands.json
  echo "No file"
endif

