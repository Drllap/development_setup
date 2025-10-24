# Add symbolik link for init.vim for NeoVim
New-Item -Path $env:LOCALAPPDATA\ -Name nvim -ItemType SymbolicLink -Value .\NeoVim\ -Force

# Add symbolic link PowerShell profile
New-Item -Path (Split-Path $PROFILE.CurrentUserAllHosts) -Name (Split-Path $PROFILE.CurrentUserAllHosts -Leaf) `
    -ItemType SymbolicLink -Value ${PWD}\WindowsTerminal\powershell_profile.ps1 -Force

# Add symbolic link PowerShell profile for PS7. The above is for PS5
New-Item -Path (Split-Path $PROFILE.CurrentUserAllHosts) -Name (Split-Path $PROFILE.CurrentUserAllHosts -Leaf) `
    -ItemType SymbolicLink -Value ${PWD}\WindowsTerminal\powershell_profile.ps1 -Force

# Install vim-plug
# Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
#     New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

# Add SymbolicLink to settings.json for Windows Terminal
New-Item -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\ -Name settings.json `
    -Value .\WindowsTerminal\settings.json -ItemType SymbolicLink -Force

# Add Symbolic Link to the Alacritty config
New-Item -Path $env:APPDATA\ -Name .\alacritty -Value .\Alacritty\ `
        -ItemType SymbolicLink -Force

# Add Symbolic Link to the Wezterm config
New-Item -Path $HOME\.config\wezterm -Name .\wezterm.lua -Value .\wezterm\.wezterm.lua `
        -ItemType SymbolicLink -Force

# Add Symbolic Link to the Rio terminal config
New-Item -Path $env:LOCALAPPDATA\ -Name rio -Target $PWD\rio\.config\rio  -ItemType SymbolicLink -Force

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop bucket add extras
scoop bucket add versions
scoop bucket add sysinternals
scoop install                   `
    git                         `
    gh                          `
    unzip                       `
    7zip                        `
    jq                          `
    jid                         `
    ripgrep                     `
    fzf                         `
    fd                          `
    eza                         `
    bat                         `
    less                        `
    tre                         `
    bottom                      `
    gsudo                       `
    curl                        `
    openssh                     `
    # openvpn                     `
    gpg4win                     `
    putty                       `
    zoxide                      `
    oh-my-posh                  `
    cmake                       `
    ninja                       `
    llvm                        `
    nasm                        `
    perl                        `
    flatc                       `
    rustup                      `
    go                          `
    nodejs                      `
    yarn                        ` # Usesed by iamcco/markdown-preview.nvim
    octave                      `
    lua-language-server         `
    pwsh                        `
    nu                          `
    # extras/wezterm-nightly      `
    versions/wezterm-nightly    `
    alacritty                   `
    rio                         `
    windows-terminal            `
    vim                         `
    neovim                      `
    # versions/neovim-nightly     `
    neovide                     `
    helix                       `
    notepadplusplus             `
    dbeaver                     `
    imhex                       `
    process-explorer            `
    harper                      `
    # powertoys                   `
    # nmap                        `
    # ffmpeg                      `
    # draw.io                     `
    # slack                       `

# setup git
git config --global user.email "drllap@gmail.com"
git config --global user.name "Pall Palsson"
git config --global core.editor "nvim"  # Use NeoVim as git editor
git config --global core.symlink true
git config --global pull.rebase true
git config --global pull.autoSetupRemote true
git config --global rebase.autoStash true
git config --global rebase.updateRefs true
git config --global merge.autoStash true

# Update PowerShellGet and Dependences (PackageManagement)
Install-Module -Name PowerShellGet -Scope CurrentUser -Force -AllowClobber

# Update PSReadLine,
#   -Force needed because older version is built in
Install-Module PSReadLine -Force

# Install-Module -Name PSFzf -Scope CurrentUser          # Wrapper for fzf
# Install-Module -Name npm-completion -Scope CurrentUser   # Tab autocompletion for nodes npm
Install-Module -Name posh-git -Scope CurrentUser         # Git tab autocompletion
# Install-Module -Name PowerColorLS -Scope CurrentUser     # Better (colorfull) ls/dir command
# Install-Module -Name Terminal-Icons -Scope CurrentUser   # Dependency of PowerColorLS
# Install-Module -Name z -Scope CurrentUser -AllowClobber  # Navigation module for PowerShell, similar to autojump
# Install-Module -Name DockerCompletion -Scope CurrentUser # Add tab Autocompletion for docker

# Download and install PowerShell LSP Server into ../LSP-Servers
mkdir ../LSP-Servers
Invoke-WebRequest `
    https://github.com/PowerShell/PowerShellEditorServices/releases/download/v2.5.2/PowerShellEditorServices.zip `
    -OutFile PowerShellEditorServices.zip
Expand-Archive PowerShellEditorServices.zip -DestinationPath "../LSP-Servers/PowerShellEditorServices"
Remove-Item PowerShellEditorServices.zip

# # Download and Install lua-language-server (sumneko_lua) into ../LSP-Servers    # We can install this via scoop
# git clone https://github.com/sumneko/lua-language-server ../LSP-Servers/lua-language-server
# Push-Location ../LSP-Servers/lua-language-server/
# git submodule update --init --recursive
# Set-Location 3rd/luamake
# compile/install.bat
# Set-Location ../..
# 3rd/luamake/luamake.exe rebuild
# Pop-Location

# Install pyright, python LSP server, requires NodeJS
# npm install -g pyright    # Install pyrigh with pip instead
npm install -g              `
    vim-language-server     `
    bash-language-server    `
    yaml-language-server    ` # LSP server for yaml
    @vlabo/cspell-lsp       ` # LSP for spell spell checking using CSpell

pip3 install                `
    neovim                  `
    pywin32                 `
    pyright                 `
    cmake-language-server   `
    conan                   `
    pyreadline  # Needed for tab autocompletion in python shell

