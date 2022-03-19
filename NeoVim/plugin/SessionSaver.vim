autocmd VimLeave * silent call SessionSaver#Save()
autocmd VimEnter * nested silent call SessionSaver#Restore()

