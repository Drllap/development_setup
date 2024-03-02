#!/bin/bash

function keys_read_from_file() {
    local scriptDir=$(dirname $BASH_SOURCE)
    local plain="$scriptDir/plain.txt"
    if [ -f $plain ] ; then
        local keys=$(awk -F : '{ gsub(" ", "", $2); print $1 "=" $2 }' $plain)
        export $keys
        export OPENAI_API_KEY=$KVIKNA_OPENAI_API_KEY # currently using he Kvikna key
    else
        echo "Can't find plain.txt file with secrets"
    fi
}
keys_read_from_file
unset -f keys_read_from_file

function keys_encrypt_file() {
    local scriptDir=$(dirname $BASH_SOURCE)
    gpg --pinentry-mode loopback --output "$scriptDir/encrypted.gpg" --symmetric "$scriptDir/plain.txt" &&
        sha256sum "$scriptDir/plain.txt" > "$scriptDir/plain.txt.sha256sum"
};

function keys_check() {
    local scriptDir=$(dirname $BASH_SOURCE)
    local plain=$scriptDir/plain.txt;
    local shaFile=$plain.sha256sum

    if [ ! -f $plain ] ; then
        echo "The plain file doesn't exist: $plain"
        return;
    fi

    read file_sha fle < "$shaFile"
    read calc_sha _ < <(sha256sum "$plain")

    if [ "$file_sha" == "$calc_sha" ] ; then
        echo "The file sha and calculated sha match"
    else
        echo "The file sha and calculated sha are different. The plain file needs to be updated"
    fi
}

function keys_decrypt() {
    local scriptDir=$(dirname $BASH_SOURCE)
    gpg --pinentry-mode loopback --decrypt --output $scriptDir/plain.txt $scriptDir/encrypted.gpg
}
