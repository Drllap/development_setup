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

