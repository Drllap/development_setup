function j {
    python $Env:APPDATA\..\Local\autojump\bin\autojump $args
}

function autojump {
    python $Env:APPDATA\..\Local\autojump\bin\autojump $args
}

function test {
    echo "STFU"
    echo "STFU2"
}

# re-source the profile
# refresh profile: . so
function so {
    . $PROFILE.CurrentUserAllHosts
    echo "re-sourcing profile: " $PROFILE.CurrentUserAllHosts
}

# Code taken from https://github.com/microsoft/terminal/issues/3158#issuecomment-789198188
# Makes make new split panes open in current directory
# My changes:
#       Instead of executing "$prevprompt" explicitly execute the prompt from posh-git
#       This is done because posh-git doesn't overwrite the prompt function if it
#       already exists.
if($env:WT_SESSION){
    # $prevprompt = $Function:prompt
    function prompt {
        if ($pwd.provider.name -eq "FileSystem") {
	    $p = $pwd.providerpath
            $esc = [char]27
	    write-host "$esc]9;9;`"$p`"$esc\" -NoNewline
        }
        # return $prevprompt.invoke()
        return $GitPromptScriptBlock.Invoke()
    }
}

$dockerCompletionModule = (Get-Item $PSCommandPath).Target | Split-Path | Join-Path -ChildPath "\DockerCompletion\DockerCompletion"
Import-Module $dockerCompletionModule # Add tab Autocompletion for docker

Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1 # Add tab Autocompletion for Chocolatey

Import-Module npm-completion    # Add tab Autocompletion for npm

