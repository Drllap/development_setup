" Work in progress
function! Resetter#ResetLuaInit() abort
    lua for k in pairs(package.loaded) do  package.loaded[k] = nil; print("just nil-ed the thing") end
endfunction

function! Resetter#RunTestVimFile() abort
    " echom a:file
    write
    source
endfun

