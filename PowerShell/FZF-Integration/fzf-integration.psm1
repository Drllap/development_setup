function sdf {
    fd --type d | fzf | Set-Location
}

function wtf {

    $trees = & {
        git -C C:\Development\development_setup worktree list
        git -C D:\dev\Norbit\wbms-gui\source worktree list
        git -C D:\dev\Norbit\wbm-file-lib\source worktree list
        git -C D:\dev\Norbit\wbm-tool\source worktree list
        git -C D:\dev\Norbit\wbm-file-info-manager worktree list
        git -C D:\dev\Norbit\wbm-file-nav-interface\source worktree list
        git -C D:\dev\Norbit\aplnx-grps\source worktree list
        git -C D:\dev\Norbit\tss1-lib\source worktree list
        git -C D:\dev\Norbit\em3000-wbm-types\source worktree list
        git -C D:\dev\Norbit\em3000-ipos-wrapper\source worktree list
        git -C D:\dev\Norbit\rotator-wbm-types\source worktree list
        git -C D:\dev\Norbit\rotator-ipos-wrapper\source worktree list
        git -C D:\dev\Norbit\sbg-wbm-types\source worktree list
        git -C D:\dev\Norbit\sbg-ipos-wrapper\source worktree list
        git -C D:\dev\Norbit\rotator-api\source worktree list
        git -C D:\dev\Norbit\sim-em-ulator\source worktree list
        git -C D:\dev\Norbit\wbmsgui-build-dependencies worktree list
    };

    $selected = $trees | fzf --cycle

    if (-not $selected) {
        Write-Output "no file selected"
        return;
    }

    $path = $selected.split()[0]
    Set-Location $path
}

function mod {
    $module = ("FZF-Integration", "Gitlab-Integration", "Vim-Session" | fzf --cycle);
    if ($null -eq $module ) { return; }

    Remove-Module $module -ErrorAction SilentlyContinue;
    Import-Module $module -Global -DisableNameChecking;
}

function Norbit {
    $session_file = fd . --extension vim --max-depth 1 D:/dev/Norbit | fzf
    if ($null -ne $session_file) {
        nvim -S $session_file;
    }
}


# function Get-ProjectDirs {
#     return "D:\dev\Norbit\";
# }

# function pcd {
#     $dirs = Get-ProjectDirs;
#     $dest = fd . $dirs --type directory --max-depth 2 | fzf;
#     Set-Location $dest;
# }

# function search-for-git($Path, $depth) {

#     $is_git_repo = git rev-parse --is-inside-work-tree 2>&1
#     if ($is_git_repo -eq "True") {
#         return $Path
#     }

#     if ($depth -le 0) {
#         echo "p: $Path"
#         echo "wtf: $depth"
#         return $false
#     }

#     $children = Get-ChildItem -Directory -Path $Path
    
#     return $children
# }

# function wcd {
#     return search-for-git "boost2" 2
# }
#
# function sdfzf {
#     fd --type d | fzf | Set-Location
# }

# function pcd {
    # $dirs = Get-ProjectDirs;
    # $dest = fd . $dirs --type directory --max-depth 2 | fzf;
    # if ($dest -ne $null) {
        # Set-Location $dest;
    # }
# }
