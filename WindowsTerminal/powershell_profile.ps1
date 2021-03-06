$ExecStart = Get-Date

$private:setup_dir = (Get-Item (Get-Item $PSCommandPath).Target).Directory.Parent
$env:LSP_Servers = $setup_dir.Parent.FullName + "\LSP-Servers\"

if($env:COMPUTERNAME -eq "DESKTOP-8GI3BII") {
    $private:Paths = @(
        "C:\WINDOWS\system32;"
        "C:\tools\Anaconda3;"
        "C:\tools\Anaconda3\Library\bin;"
        "C:\tools\Anaconda3\Scripts;"
        "C:\Windows\System32\WindowsPowerShell\v1.0\;"
        "C:\Windows\System32\OpenSSH\;"
        "C:\tools\neovim\nvim-win64\bin\;" # This needs to be above the chocolatey folder
                                           # so the the win32yank from that is prefered over the
                                           # one in chocolatey. The WSL will use the other one.
                                           # See bash/bash_profile
        "C:\ProgramData\chocolatey\bin;"
        # "C:\Program Files\PostgreSQL\12\bin;",
        "C:\Program Files\Cmake\bin;"
        "C:\Program Files\LLVM\bin;"
        "C:\Program Files\Docker\Docker\resources\bin;"
        "C:\ProgramData\DockerDesktop\version-bin;"
        # "C:\Program Files\dotnet\;",
        "C:\Program Files\Git\cmd;",
        "C:\Program Files\nodejs\;",
        # "C:\Users\noob-destroyer\AppData\Local\Microsoft\WindowsApps;",
        "C:\Program Files\GitHub CLI\;",
        "C:\Users\noob-destroyer\AppData\Roaming\npm;"
        "C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin;"
        "C:\tools\vim\vim82;"
    );
} elseif($env:COMPUTERNAME -eq "K-WIN10-29") {
    $private:Paths = @(
        "C:\tools\Anaconda3;",
        # "C:\tools\Anaconda3\Library\mingw-w64\bin;",
        # "C:\tools\Anaconda3\Library\usr\bin;",
        "C:\tools\Anaconda3\Library\bin;",
        "C:\tools\Anaconda3\Scripts;",
        "C:\WINDOWS\system32;",
        "C:\WINDOWS;",
        # "C:\WINDOWS\System32\Wbem;",
        "C:\WINDOWS\System32\WindowsPowerShell\v1.0\;",
        "C:\ProgramData\chocolatey\bin;",
        "C:\Program Files\CMake\bin;",
        # "C:\Program Files\Maven\apache-maven-3.5.0\bin;",
        # "C:\Program Files\dotnet\;",
        "C:\WINDOWS\System32\OpenSSH\;",
        # "C:\Program Files\doxygen\bin;",
        # "C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;",
        "C:\Program Files\nodejs\;",
        "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\MSBuild\Current\Bin;",
        # "C:\Program Files (x86)\dotnet\;",
        # "C:\Program Files\TortoiseGit\bin;",
        # "C:\Program Files (x86)\Common Files\Oracle\Java\javapath;",
        # "C:\Program Files\Intel\Intel(R) Management Engine Components\DAL;",
        # "C:\Program Files\Intel\Intel(R) Management Engine Components\iCLS\;",
        # "C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\iCLS\;",
        # "C:\Program Files (x86)\Intel\Intel(R) Management Engine Components\DAL;",
        # "C:\Program Files\IVI Foundation\VISA\Win64\Bin\;",
        # "C:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin;",
        # "C:\Program Files (x86)\IVI Foundation\VISA\WinNT\Bin\;",
        "C:\Program Files\Go\bin;",
        "C:\Program Files\LLVM\bin;",
        "C:\Program Files\Git\cmd;",
        "C:\Program Files\Docker\Docker\resources\bin;",
        "C:\ProgramData\DockerDesktop\version-bin;",
        # "C:\Development\LSP-Servers\lua-language-server\3rd\luamake;",
        # "C:\tools\cmder;",
        # "C:\Program Files\Microsoft VS Code\bin;",
        "C:\Users\palli\AppData\Roaming\npm;",
        "C:\tools\neovim\nvim-win64\bin\;",
        "C:\Program Files (x86)\GitHub CLI\;",
        "C:\Users\palli\AppData\Local\Microsoft\WindowsApps;",
        "C:\Users\palli\.dotnet\tools;",
        "C:\Users\palli\go\bin;"
        # "C:\tools\neovim\Neovim\bin;"
    );
}

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

Import-Module PSReadLine -RequiredVersion "2.2.0"
# Remove-Module PSReadLine -Force
# Import-Module PSReadLine -RequiredVersion "2.1.0"

Import-Module posh-git  # posh-git, git info in prompt and auto tab completion

$dockerCompletionModule = (Get-Item $PSCommandPath).Target | Split-Path | Join-Path -ChildPath "\DockerCompletion\DockerCompletion"
Import-Module $dockerCompletionModule # Add tab Autocompletion for docker
 
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1 # Add tab Autocompletion for Chocolatey
 
Import-Module npm-completion    # Add tab Autocompletion for npm

Import-Module z # Autojump like module

# Configure PowerColorLS
Set-Alias -Name ls -Value PowerColorLS -Option AllScope # Use PowerColorLS as default ls command

# Set the theme for oh-my-posh
# Set-PoshPrompt -Theme honukai
Set-PoshPrompt -Theme jv_sitecorian

# Add tab Autocompletion for GitHub Cli by sourcing a file that can be generated by
# gh completion -s powershell > github-cli-completion.ps1
. ($setup_dir.FullName + "\WindowsTerminal\github-cli-completion.ps1")

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

$ExecEnd = Get-Date
Write-Host "Profile Load Time: $(($ExecEnd - $ExecStart).Milliseconds) Milliseconds"
