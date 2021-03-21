# Add symbolik link for init.vim for NeoVim
New-Item -Name $env:LOCALAPPDATA\nvim\init.vim -ItemType SymbolicLink -Value .\NeoVim\init.vim

# install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/vimfiles/autoload/plug.vim -Force


