$ExecStart = Get-Date

$private:developer_setup = (Get-Item (Get-Item $PSCommandPath).Target).Directory.Parent
$env:LSP_Servers = $developer_setup.Parent.FullName + "\LSP-Servers\"

$env:PSModulePath = $developer_setup.FullName + "\PowerShell;" + $env:PSModulePath
. ($developer_setup.FullName + "\PowerShell\keys.ps1")

$private:Paths = New-Object System.Collections.ArrayList

if($env:COMPUTERNAME -eq "DESKTOP-8GI3BII") {
    $private:Paths.AddRange((
        # "C:\Windows\System32\WindowsPowerShell\v1.0\;",
        "C:\Program Files\PostgreSQL\14\bin;"
    ));
} elseif($env:COMPUTERNAME -eq "K-WIN10-29") {
    $private:Paths.AddRange((
        # "C:\Program Files\doxygen\bin;",
        # "C:\Program Files\Microsoft SQL Server\130\Tools\Binn\;",
        "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin;",
        "C:\Users\palli\AppData\Local\Microsoft\WindowsApps;",
        # "C:\Users\palli\.dotnet\tools;",
        "C:\Program Files\Sublime Text 3;"
    ));
}

$private:Paths.AddRange((
    # "C:\WINDOWS;",
    "C:\WINDOWS\System32;",
    -Join($env:USERPROFILE, "\scoop\shims\;"),
    -Join($env:USERPROFILE, "\scoop\apps\llvm\current\bin\;"),
    -Join($env:USERPROFILE, "\scoop\apps\rustup\current\.cargo\bin\;"),
    -Join($env:USERPROFILE, "\scoop\apps\perl\current\perl\bin;"),
    -Join($env:USERPROFILE, "\scoop\apps\nodejs\current\;"),                        # this
    # -Join($env:USERPROFILE, "\scoop\apps\nodejs\current\bin\;"),                    # this
    -Join($env:USERPROFILE, "\scoop\apps\yarn\current\bin\;"),                      # this
    # -Join($env:USERPROFILE, "\scoop\apps\yarn\current\global\node_modules\.bin\;"), # this
    -Join($env:USERPROFILE, "\scoop\apps\gpg4win\current\GnuPG\bin;"),
    -Join($env:USERPROFILE, "\scoop\apps\gpg4win\current\Gpg4win\bin;"),
    -Join($env:APPDATA, "\Python\Python39\Scripts\;"),
    # -Join($env:APPDATA, "\npm;"),
    # -Join($env:USERPROFILE, "\.cargo\bin\;"),
    # "C:\Program Files\nodejs\;",
    "C:\Program Files\Docker\Docker\resources\bin;",
    "C:\ProgramData\chocolatey\lib\mingw\tools\install\mingw64\bin\;",  # This needs to be before the neovim folder,
                                                                        # see commit msg for details
    # "C:\tools\neovim\nvim-win64\bin\;", # This needs to be above the chocolatey folder
    #                                     # so the win32yank from that is preferred over the
    #                                     # one in chocolatey. The WSL will use the other one .
    #                                     # See bash/bash_profile
    "C:\tools\miniconda3;",
    "C:\tools\miniconda3\Library\bin;",
    "C:\tools\miniconda3\Scripts;",
    "C:\ProgramData\chocolatey\bin;",
    "C:\ProgramData\DockerDesktop\version-bin;",
    -Join($env:USERPROFILE, "\.local\bin;")
    # -Join($env:LOCALAPPDATA, "\Yarn\bin;")
))

if ($null -ne $Paths) {
    $env:Path = $Paths -join '';
} else {
    Write-Warning "Path for current COMPUTERNAME not set: $env:COMPUTERNAME ,keeping the system path"
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

Invoke-Expression (& { (zoxide init powershell --cmd go | Out-String) })

# Configure PowerColorLS
Set-Alias -Name ls -Value PowerColorLS -Option AllScope # Use PowerColorLS as default ls command

oh-my-posh init powershell --config "$env:POSH_THEMES_PATH\jv_sitecorian.omp.json" | Invoke-Expression
oh-my-posh completion powershell | Out-String | Invoke-Expression

# WezTerm autocompletion
wezterm shell-completion --shell power-shell | Out-String | Invoke-Expression

# Add tab Autocompletion for GitHub Cli
gh completion -s powershell | Out-String | Invoke-Expression

# Add tab Autocompletion for rustup
rustup completions powershell | Out-String | Invoke-Expression

# Code taken from https://github.com/microsoft/terminal/issues/3158#issuecomment-789198188
# Makes make new split panes open in current directory
# My changes:
#       Instead of executing "$prevprompt" explicitly execute the prompt from posh-git
#       This is done because posh-git doesn't overwrite the prompt function if it
#       already exists.
if ($env:WT_SESSION) {
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
        # Add-Member                                          `
        #     -InputObject $PWD                               `
        #     -Name Nix                                       `
        #     -Value { return $this.Path.Replace('\','/'); }  `
        #     -MemberType ScriptProperty

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
Remove-Item alias:nv -Force # nv is already a builtin alias for New-Variable
$env:NEOVIDE_FRAME="none"   # Remove the frame from neovide by default, the default is "full"
Set-Alias -Name nv      -Value "neovide"
Set-Alias -Name wez     -Value "wezterm"
Set-Alias -Name wt      -Value "wezterm"
Set-Alias -Name wh      -Value "where.exe"
Remove-Item alias:curl  # curl is bound to Invoke-WebRequest by default
Set-Alias -Name curl    -Value C:\ProgramData\chocolatey\bin\curl.exe
Set-Alias -Name tree    -Value C:\ProgramData\chocolatey\bin\tree.exe

# Set environment
$env:CMAKE_EXPORT_COMPILE_COMMANDS="ON";
$env:BUILD_TESTING="ON"

# Set options for PSReadLine module
# Change the cursor when going in and out of Vi mode
if ($PSVersionTable.PSVersion.Major -eq 5) {
    # We need to handle PowerShell 5 specially
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
 
Set-PSReadLineKeyHandler -Key Ctrl+n -ViMode Insert -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+p -ViMode Insert -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+n -ViMode Command -Function NextHistory
Set-PSReadLineKeyHandler -Key Ctrl+p -ViMode Command -Function PreviousHistory
Set-PSReadLineKeyHandler -Key Ctrl+K -Function ShowParameterHelp
Set-PSReadLineKeyHandler -Key Ctrl+k -Function ShowCommandHelp

# Set scroll functions start
# These Scrolling function only work in the PowerShell terminal emulator
# they don't work in WezTerm/WindowsTerminal
Set-PSReadLineKeyHandler -Key Ctrl+e -Function ScrollDisplayUpLine
Set-PSReadLineKeyHandler -Key Ctrl+y -Function ScrollDisplayUpLine

Set-PSReadLineKeyHandler -Key j -ViMode Command -Function ScrollDisplayDownLine
Set-PSReadLineKeyHandler -Key k -ViMode Command -Function ScrollDisplayUpLine
Set-PSReadLineKeyHandler -Key J -ViMode Command -Function ScrollDisplayDown
Set-PSReadLineKeyHandler -Key K -ViMode Command -Function ScrollDisplayUp
# Set scroll functions end

Set-PSReadLineKeyHandler -Key Tab -Function Complete    # Changes compleation to bash-like, only compleate to divergence

Import-Module 'C:\tools\gsudo\Current\gsudoModule.psd1' # Enable gsudo !! (and maybe other things)

function toggle_conda {
    if (Test-Path 'Env:CONDA_EXE') {
        Write-Host "Deactivating Conda"

        # CONDA_PROMPT_MODIFIER has the environment name withing parentheses. Extracting the name
        $Env:CONDA_PREVIOUS_ACTIVE_ENV = [RegEx]::Matches($env:CONDA_PROMPT_MODIFIER, "\((.*)\)").groups[1].Value;

        Remove-Module Conda
        Remove-Item 'Env:CONDA_EXE'
        # Remove-Item 'Env:_CE_M'
        # Remove-Item 'Env:_CE_CONDA'
        Remove-Item 'Env:_CONDA_ROOT'
        Remove-Item 'Env:_CONDA_EXE'

    } else {
        Write-Host "Activating Conda"
        $Env:CONDA_EXE = "C:\tools\miniconda3\Scripts\conda.exe"
        # $Env:_CE_M = ""
        # $Env:_CE_CONDA = ""
        $Env:_CONDA_ROOT = "C:\tools\miniconda3"
        $Env:_CONDA_EXE = "C:\tools\miniconda3\Scripts\conda.exe"
        $CondaModuleArgs = @{ChangePs1 = $false}
        Import-Module "$Env:_CONDA_ROOT\shell\condabin\Conda.psm1" -ArgumentList $CondaModuleArgs

        if (Test-Path 'Env:CONDA_PREVIOUS_ACTIVE_ENV') {
            $environment = [RegEx]::Matches($env:CONDA_PROMPT_MODIFIER, "\((.*)\)").groups[1].Value
        } else {
            $environment = $env:CONDA_DEFAULT_ENV
        }

        conda activate $environment
    }

# The above in influenced what is returned by call to 'conda "shell.powershell" "hook"'
# See: conda init powershell --dry-run --verbose

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
# (& "C:\tools\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
}

function enable_VSDevShell {
    $current = Get-Location;
    Import-Module ('C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\' +
                   'Common7\Tools\Microsoft.VisualStudio.DevShell.dll');
    Enter-VsDevShell b0c0bd68;  # This changes the CWD to C:\Users\<user>\source\repos for some reason
    Set-Location $current
}

function msb {
    $target = Get-ChildItem -Path . -File "*.sln"
    if ($target.count -ne 1) {
        Write-Host "There should only be one *.sln file"
        Write-Host "Found: " $target
        return 
    }

    MSBuild $target
}

$ExecEnd = Get-Date
Write-Host "Profile Load Time: $(($ExecEnd - $ExecStart).Milliseconds) Milliseconds"

