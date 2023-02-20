$ExecStart = Get-Date

$private:setup_dir = (Get-Item (Get-Item $PSCommandPath).Target).Directory.Parent
$env:LSP_Servers = $setup_dir.Parent.FullName + "\LSP-Servers\"
$private:Paths = New-Object System.Collections.ArrayList

if($env:COMPUTERNAME -eq "DESKTOP-8GI3BII") {
    $private:Paths.AddRange((
        "C:\Windows\System32\WindowsPowerShell\v1.0\;",
        "C:\Program Files\PostgreSQL\14\bin;"
    ));
} elseif($env:COMPUTERNAME -eq "K-WIN10-29") {
    $private:Paths.AddRange((
        # "C:\Program Files\doxygen\bin;",
        # "C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin;",
        # "C:\Program Files (x86)\dotnet\;",
        # "C:\Program Files\TortoiseGit\bin;",
        # "C:\Development\LSP-Servers\lua-language-server\3rd\luamake;",
        # "C:\Program Files\Microsoft VS Code\bin;",
        "C:\Users\palli\AppData\Local\Microsoft\WindowsApps;",
        "C:\Users\palli\.dotnet\tools;",
        "C:\Users\palli\go\bin;"
    ));
}

$private:Paths.AddRange((
    -join($env:APPDATA, "\Python\Python39\Scripts;"),
    -Join($env:APPDATA, "\npm;"),
    "C:\WINDOWS;",
    "C:\WINDOWS\system32;",
    "C:\WINDOWS\System32\WindowsPowerShell\v1.0\;",
    "C:\WINDOWS\System32\OpenSSH\;",
    "C:\Program Files (x86)\oh-my-posh\bin;",
    "C:\Program Files\GitHub CLI\;",
    "C:\Program Files\Cmake\bin;",
    "C:\Program Files\LLVM\bin;",
    "C:\Program Files\Git\cmd;",
    "C:\Program Files\Go\bin;",
    "C:\Program Files\nodejs\;",
    "C:\Program Files\Docker\Docker\resources\bin;",
    "C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin\;",  # This needs to be before the neovim folder,
                                                                        # see commit msg for details
    "C:\tools\neovim\nvim-win64\bin\;", # This needs to be above the chocolatey folder
                                        # so the win32yank from that is preferred over the
                                        # one in chocolatey. The WSL will use the other one .
                                        # See bash/bash_profile
    "C:\tools\miniconda3;",
    "C:\tools\miniconda3\Library\bin;",
    "C:\tools\miniconda3\Scripts;",
    "C:\tools\gsudo\Current;",
    "C:\tools\vim\vim82;",
    "C:\ProgramData\chocolatey\bin;",
    "C:\ProgramData\DockerDesktop\version-bin;"
))

if($null -ne $Paths) {
    $env:Path = $Paths -join '';
} else {
    Write-Warning "Path for current COMPUTERNAME not set: $env:COMPUTERNAME ,keeping the system path"
}

# function j {
#     python $Env:APPDATA\..\Local\autojump\bin\autojump $args
# }

function autojump {
    python $Env:APPDATA\..\Local\autojump\bin\autojump $args
}

function test {
    Write-Output "STFU"
    Write-Output "STFU2"
}

# re-source the profile
# refresh profile: . so
function so {
    . $PROFILE.CurrentUserAllHosts
    Write-Host "re-sourcing profile: " $PROFILE.CurrentUserAllHosts
}

Import-Module PSReadLine -MinimumVersion "2.2.3"

Import-Module posh-git  # posh-git, git info in prompt and auto tab completion

Import-Module DockerCompletion # Add tab Autocompletion for docker
 
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1 # Add tab Autocompletion for Chocolatey
 
Import-Module npm-completion    # Add tab Autocompletion for npm

Import-Module z # Autojump like module

# Configure PowerColorLS
Set-Alias -Name ls -Value PowerColorLS -Option AllScope # Use PowerColorLS as default ls command

oh-my-posh init powershell --config "$env:POSH_THEMES_PATH\jv_sitecorian.omp.json" | Invoke-Expression
oh-my-posh completion powershell | Out-String | Invoke-Expression

# Add tab Autocompletion for GitHub Cli
gh completion -s powershell | Out-String | Invoke-Expression

# Code taken from https://github.com/microsoft/terminal/issues/3158#issuecomment-789198188
# Makes make new split panes open in current directory
# My changes:
#       Instead of executing "$prevprompt" explicitly execute the prompt from posh-git
#       This is done because posh-git doesn't overwrite the prompt function if it
#       already exists.
if($env:WT_SESSION){
    $prevprompt = $Function:prompt
    function prompt {
        if ($pwd.provider.name -eq "FileSystem") {
          $p = $pwd.providerpath
          $esc = [char]27
          Write-Host "$esc]9;9;`"$p`"$esc\" -NoNewline
          
          $esc = "$([char]0x1b)"
          Write-Host -NoNewline "${esc}[5 q"
        }

        # Add Nix property to $PWD, returns the path in UNIX style
        Add-Member                                          `
            -InputObject $PWD                               `
            -Name Nix                                       `
            -Value { return $this.Path.Replace('\','/'); }  `
            -MemberType ScriptProperty

        return $prevprompt.invoke()
    }
}

# Set-Alias -Name cmd     -Value C:\Windows\System32\cmd.exe
# Set-Alias -Name cmd.exe -Value C:\Windows\System32\cmd.exe
Set-Alias -Name ub      -Value ($env:LOCALAPPDATA | Join-Path -ChildPath "Microsoft\WindowsApps\ubuntu2004.exe")
Set-Alias -Name MSBuild -Value "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin\MSBuild.exe"
Set-Alias -Name vswhere -Value "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"
Set-Alias -Name LuaJIT  -Value "F:\Development\luajit\installation\luajit.exe"
Set-Alias -Name nn      -Value "nvim-qt"

# Set opstions for PSReadLIne module
# Change the cursor when goin in and out of Vi mode
if ($PSVersionTable.PSVersion.Major -eq 5) {
    # We need to hande PowerShell 5 specially
    # https://github.com/PowerShell/PSReadLine/issues/3159#issuecomment-1015001655
    function Script:OnViModeChange {
        $esc = "$([char]0x1b)"
        if ($args[0] -eq 'Command') {
            # Set the cursor to a blinking block.
            Write-Host -NoNewline "${esc}[1 q"
            # Write-Host "$esc e[1 q" -NoNewLine
        } else {
            # Set the cursor to a blinking line.
            Write-Host -NoNewline "${esc}[5 q"
        }
    }
} else {
    # https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?
    # view=powershell-7.2#example-6--use-vimodechangehandler-to-display-vi-mode-changes
    function Script:OnViModeChange {
        if ($args[0] -eq 'Command') {
            # Set the cursor to a blinking block.
            Write-Host -NoNewLine "`e[1 q"
        } else {
            # Set the cursor to a blinking line.
            Write-Host -NoNewLine "`e[5 q"
        }
    }
}

$env:VISUAL = "nvim"    # When in Command Mod, <v> will open the current line content in nvim

$Script:PSReadLineOptions = @{
    EditMode = "Vi"
    BellStyle = "Visual"
    PredictionSource = "History"
    PredictionViewStyle = "ListView"
    ViModeIndicator = "Script"
    ViModeChangeHandler = $Function:OnViModeChange
}
Set-PSReadLineOption @PSReadLineOptions


$j_timer = New-Object System.Diagnostics.Stopwatch

Set-PSReadLineKeyHandler -Key j -ViMode Insert -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("j")
    $j_timer.Restart()
}

Set-PSReadLineKeyHandler -Key k -ViMode Insert -ScriptBlock {
    if (!$j_timer.IsRunning -or $j_timer.ElapsedMilliseconds -gt 1000) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("k")
    } else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor, 1)
        [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor-1)
    }
}
 
Set-PSReadLineKeyHandler -Key Ctrl+n -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+K -Function ShowParameterHelp
Set-PSReadLineKeyHandler -Key Ctrl+k -Function ShowCommandHelp

# Set-PSReadLineKeyHandler -Key Ctrl+e -Function ScrollDisplayUpLine

Set-PSReadLineKeyHandler -Key Tab -Function Complete    # Changes compleation to bash-like, only compleate to divergence

Import-Module 'C:\tools\gsudo\Current\gsudoModule.psd1' # Enable gsudo !! (and maybe other things)

$ExecEnd = Get-Date
Write-Host "Profile Load Time: $(($ExecEnd - $ExecStart).Milliseconds) Milliseconds"
