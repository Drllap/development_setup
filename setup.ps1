# Add symbolik link for init.vim for NeoVim
New-Item -Path $env:LOCALAPPDATA\ -Name nvim -ItemType SymbolicLink -Value .\NeoVim\ -Force

# Add symbolic link PowerShell profile
New-Item -Path (Split-Path $PROFILE.CurrentUserAllHosts) -Name (Split-Path $PROFILE.CurrentUserAllHosts -Leaf) `
    -ItemType SymbolicLink -Value ${PWD}\WindowsTerminal\powershell_profile.ps1 -Force

# Install vim-plug
Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Add SymbolicLink to settings.json for Windows Terminal
New-Item -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ -Name settings.json `
    -Value .\WindowsTerminal\settings.json -ItemType SymbolicLink -Force


# setup git
git config --global user.email "drllap@gmail.com"
git config --global user.name "Pall Palsson"
git config --global core.editor "nvim"  # Use NeoVim as git editor
git config --global core.symlink true

Install-Module npm-completion -Scope CurrentUser

# Update PSReadLine, -Force needed because older version is built in
Install-Module PSReadLine -Force

# Wrapper for fzf
# Install-Module -Name PSFzf -Scope CurrentUser

Install-Module -Name oh-my-posh -Scope CurrentUser  # PowerShell promt moduel with theam support
                                                    # Depends on Neard-Fonts, see Neard-Fonst folder for
                                                    # fonts and readme for how to install

Install-Module -Name posh-git -Scope CurrentUser    # Git tab autocompleation

Install-Module -Name PowerColorLS -Scope CurrentUser    # Better (colorfull) ls/dir command
Install-Module -Name Terminal-Icons -Scope CurrentUser  # Dependency of PowerColorLS

# Download and install PowerShell LSP Server into ../LSP-Servers
mkdir ../LSP-Servers
Invoke-WebRequest `
    https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.5.2/PowerShellEditorServices.zip `
    -OutFile PowerShellEditorServices.zip
Expand-Archive PowerShellEditorServices.zip -DestinationPath "../LSP-Servers/PowerShellEditorServices"
Remove-Item PowerShellEditorServices.zip

# Download and Install lua-language-server (sumneko_lua) into ../LSP-Servers
choco install ninja
git clone https://github.com/sumneko/lua-language-server ../LSP-Servers/lua-language-server
Push-Location ../LSP-Servers/lua-language-server/
git submodule update --init --recursive
Set-Location 3rd/luamake
compile/install.bat
Set-Location ../..
3rd/luamake/luamake.exe rebuild
Pop-Location

# Install pyright, python LSP server, requires NodeJS
npm install -g pyright
