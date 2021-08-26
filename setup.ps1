# Add symbolik link for init.vim for NeoVim
New-Item -Path $env:LOCALAPPDATA\nvim\ -Name init.vim -ItemType SymbolicLink -Value .\NeoVim\init.vim -Force

# Add symbolic link PowerShell profile
New-Item -Path (Split-Path $PROFILE.CurrentUserAllHosts) -Name (Split-Path $PROFILE.CurrentUserAllHosts -Leaf) -ItemType SymbolicLink -Value .\WindowsTerminal\powershell_profile.ps1 -Force

# install vim-plug
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Add SymbolicLink to settings.json for Windows Terminal
New-Item -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ -Name settings.json `
    -Value .\WindowsTerminal\settings.json -ItemType SymbolicLink -Force

# Use NeoVim as git editor
git config --global core.editor "nvim"
