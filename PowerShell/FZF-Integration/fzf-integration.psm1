function sdf {
    fd --type d | fzf | Set-Location
}

function wtf {

    $nullDevice = if ($IsWindows) { 'NUL' } else { '/dev/null' }

    $repos = @(
        "F:\dev\mine\development_setup"
        "F:\dev\norbit\wbms-gui\source"
        "F:\dev\norbit\wbm-file-lib\source"
        "F:\dev\norbit\sem\source"
    );

    $worktrees = foreach ($repo in $repos) {
        $worktreePath = $null
        $branch = $null

        foreach ($line in (git -C $repo worktree list --porcelain 2> $nullDevice)) {
            if (-not $line) {
                if ($worktreePath) {
                    $branchName = if ($branch -like 'refs/heads/*') { $branch.Substring(11) } else { $branch }
                    [PSCustomObject]@{
                        Path = $worktreePath
                        Branch = $branchName
                    }
                }

                $worktreePath = $null
                $branch = $null
                continue
            }

            if ($line -like 'worktree *') {
                $worktreePath = $line.Substring(9)
                continue
            }

            if ($line -like 'branch *') {
                $branch = $line.Substring(7)
            }
        }

        if ($worktreePath) {
            $branchName = if ($branch -like 'refs/heads/*') { $branch.Substring(11) } else { $branch }
            [PSCustomObject]@{
                Path = $worktreePath
                Branch = $branchName
            }
        }
    }

    $maxPathLength = ($worktrees | ForEach-Object { $_.Path.Length } | Measure-Object -Maximum).Maximum
    $items = $worktrees | ForEach-Object {
        $branchLabel = if ($_.Branch) { "[{0}]" -f $_.Branch } else { '' }
        "{0}  {1}`t{2}" -f $_.Path.PadRight($maxPathLength), $branchLabel, $_.Path
    }

    $selected = $items |
        fzf `
        --delimiter "`t" `
        --with-nth 1 `
        --preview-window 'right,60%,wrap,<140(down,45%,wrap)' `
        --preview "git -C {2} -c color.status=always status --branch --short 2>$nullDevice"

    if (-not $selected) {
        Write-Output "no file selected"
        return;
    }

    Set-Location ($selected -split "`t", 2)[1]
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
