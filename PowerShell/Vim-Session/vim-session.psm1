function ses {
    $session_file = fd . --extension vim --type file `
        --exclude NeoVim    `
        --exclude build     `
        --max-depth 5       `
        D:\dev\Norbit C:\Development\development_setup | fzf --cycle;

    if(-not $session_file) {
        Write-Output "no file selected"
        return;
    }

    $folder = Split-Path -Parent $session_file
    Set-Location $folder

    $file = Split-Path -Path $session_file -Leaf

    nvim -S $file
}

function vses {
    $session_file = fd . --extension vim --type file `
        --exclude NeoVim    `
        --exclude build     `
        --max-depth 5       `
        D:\dev\Norbit C:\Development\development_setup | fzf --cycle;

    if(-not $session_file) {
        Write-Output "no file selected"
        return;
    }

    $folder = Split-Path -Parent $session_file
    Set-Location $folder

    $file = Split-Path -Path $session_file -Leaf

    neovide.exe -- -S $file
}
