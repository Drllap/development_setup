function plex_toggle {
    state=$(systemctl is-active plexmediaserver)

    if [ $state == "inactive" ]; then
        echo "Plex not running, starting"
        sudo systemctl start plexmediaserver &&
            sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
    elif [ $state == "active" ]; then
        echo "Plex is running, stopping"
        sudo systemctl stop plexmediaserver && 
            sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target
    else
        echo "Unknown state"
    fi;
}

