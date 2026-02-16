$script:TOKEN = "<the token>"
$script:server_URL = "The gitlab server"

$script:todo_mrs = 1088, 1095, 1102, 1109, 1111, 1112, 1110, 1116, 1115, 1119, 1136, 1065, 1137, 1132, 1120, 1140, `
                   1141, 1138, 1135, 1143, 1146, 1179, 1191, 1195, 1193, 1201, 1205, 1210, 1223, 1222, 1241, 1247, `
                   1249, 1256, 1263, 1282, 1297, 1302, 1295, 1296, 1308
$script:mr_to_mr_map =
    @{
        # Original = V11.3
        1088 = 1203;
        1095 = 1213;
        1102 = 1215;
        1109 = 1221;
        1111 = 1224;
        1112 = 1225;
        1110 = 1226;
        1116 = 1227;
        1115 = 1231;
        1119 = 1232;
        1136 = 1233;
        1137 = 1234;
        1065 = 1240;
        1132 = 1243;
        1120 = 1244;
        1140 = 1248;
        1141 = 1250;
        1138 = 1251;
        1135 = 1252;
        1143 = 1253;
        1146 = 1254;
        1179 = 1255;
        1191 = 1257;
        1195 = 1257;
        1193 = 1258;
        1201 = 1264;
        1205 = 1265;
        1210 = 1266;
        1223 = 1267;
        1222 = 1270;
        1241 = 1271;
        1247 = 1272;
        1249 = 1273;
        1256 = 1278;
        1263 = 1319;
        1282 = 1320;
        1297 = 1321;
        1302 = 1323;
        1295 = 1324;
        1296 = 1325;
        1308 = 1326;
    }

function Create-Table {
    $ret = [System.Collections.ArrayList]::new()
    $ret.Add("||Status||Original Issue||Original MR||V11.3 MR||");
    foreach($MR_ID in $script:todo_mrs) {
        $info = Get-MRInfo $MR_ID
        if ($script:mr_to_mr_map[$MR_ID] -ne $null) {
            $target_id = $script:mr_to_mr_map[$MR_ID];
            $target_info = Get-MRInfo $target_id;
            $status = $target_info.state.ToUpper();
            $target_url = $target_info.web_url;
            $ret.Add("|$status|$($info.title)|[$MR_ID|$($info.web_url)]|[$target_id|$target_url]|") > $null
        } else {
            $ret.Add("|TODO|$($info.title)|[$MR_ID|$($info.web_url)]|TODO|") > $null
        }
    }

    Set-Clipboard $ret

    return $ret
}

function Create-ListOfPendingFileChanges
{
    $ret;
    foreach($orginal_mr in $script:todo_mrs) {
        $target_mr = $script:mr_to_mr_map[$orginal_mr]
        if ($target_mr -ne $null) {
            $info = Get-MRInfo $target_mr
            if ($info.state -ne "merged") {
                $ret = $ret + (Get-ChangedFiles $info)
            }
        }
    }
    return $ret | Sort-Object -Unique
}

function Ready-For-MR-Creation($MR_ID)
{
    if (-Not $script:todo_mrs.Contains($MR_ID)) {
        Write-Host "The given MR: $MR_ID isn't in the todo list";
        return;
    }

    if ($script:mr_to_mr_map.ContainsKey($MR_ID)) {
        Write-Host "The given MR: $MR_ID already has a corresponding target MR: $($script:mr_to_mr_map[$MR_ID])"
        return;
    }

    # Check if all of the mrs in the todo list before the given one have a corresponding target MR
    foreach($todo in $script:todo_mrs) {
        if ($todo -eq $MR_ID) {
            # We have gone through the todo list and found the given one. The previous ones in the list
            # must all have a corresponding MR
            break;
        }

        if (-Not $script:mr_to_mr_map.ContainsKey($todo)) {
            Write-Host "There is a MR in the todo list ($todo) that should be merged before the given one: $MR_ID"
            return;
        }
    }

    Write-Host "We can prepare $MR_ID"

    $files_with_pending_changes = Create-ListOfPendingFileChanges;

    Write-Host "Pending chagnes:"
    Write-Host ($files_with_pending_changes -join "`n")
    Write-Host

    $next_info = Get-MRInfo $MR_ID;

    $next_changes = Get-ChangedFiles $next_info;
    Write-Host "Next Files:"
    Write-Host ($next_changes -join "`n")
    Write-Host

    $intersection = $files_with_pending_changes | Where-Object{$next_changes -contains $_}
    Write-Host "Files in both:"
    Write-Host ($intersection -join "`n")

    return $intersection.Count -eq 0;
}

function Get-ChangedFiles($info)
{
    $ret = git diff --name-only $($info.diff_refs.base_sha) $($info.diff_refs.head_sha)
    if($LASTEXITCODE -ne 0) {
        Write-Host "Error when listing changed files"
        return;
    }
    
    return $ret;
}

function Get-Commits($MR_ID)
{
    $commits = curl --header "PRIVATE-TOKEN: $script:TOKEN" `
        $("$script:server_URL" + `
        "/api/v4/projects/60/merge_requests/$MR_ID/commits" + `
        "?per_page=100")

    return $commits | ConvertFrom-Json
}

function Get-MRInfo($MR_ID)
{
    $response = curl --header "PRIVATE-TOKEN: $script:TOKEN" "$script:server_URL/api/v4/projects/60/merge_requests/$MR_ID"
    return $response | ConvertFrom-Json;
}

function Write-Cherry-Pick-Command($MR_ID)
{
    $commits = Get-Commits $MR_ID;
    $commits = Filter-MergeCommits $commits.id;

    if ($commits -eq $null) {
        throw "commits is null";
    }

    if ($commits.Count -eq 0) {
        throw "No commits in MR?";
    }

    if ($commits.Count -eq 1) {
        $command = "cherry-pick $commits -x";
        Set-Clipboard $command;
        return $command
    }

    [array]::Reverse($commits)

    $command = "cherry-pick ";

    foreach($c in $commits) {
        $command = $command + "$c "
    }

    $command = $command + "-x"

    Set-Clipboard $command
    return $command
}

function Get-MR-Diff($MR_ID)
{
    return curl --header "PRIVATE-TOKEN: $script:TOKEN" "$script:server_URL/api/v4/projects/60/merge_requests/$MR_ID/changes?access_raw_diffs=true"
}

function Get-CommitInfo($SHA)
{
    return curl --header "PRIVATE-TOKEN: $script:TOKEN" "$script:server_URL/api/v4/projects/60/repository/commits/$SHA"
}

function Is-MergeCommit($SHA)
{
    $commit_info = (Get-CommitInfo $SHA) | ConvertFrom-Json;
    return ($commit_info.parent_ids.Count -eq 2)
}

function Filter-MergeCommits($SHA_array)
{
    $ret = [System.Collections.ArrayList]::new();
    foreach($SHA in $SHA_array) {
        if ($true -eq (Is-MergeCommit $SHA)) {
        } else {
            $ret.Add($SHA) > $null
        }
    }
    
    return $ret;
}

function Get-SourceBranchName($MR_INFO)
{
    return "$($MR_INFO.source_branch)-V11.3"
}

function Get-Title($MR_INFO)
{
    return "$($MR_INFO.title)-V11.3"
}

function Get-Description($MR_INFO)
{
    $origian_mr_id = $MR_INFO.iid
    return $original = $MR_INFO.description + "`n`nRelated to WBMSGUI-1389`n`nChanges taken from !$origian_mr_id"
}

function Checkout-CherryPickingBranch($MR_ID)
{
    $info = Get-MRInfo $MR_ID
    $target_branch = Get-SourceBranchName $info

    git checkout -b $target_branch "origin/dev/V11.3.2" --no-track
}

# Prepare a local branch for doing the cherrypicking
# Checkout-CherryPickingBranch <the MR to cherrypick>
# Create the cherrypikcing command
# Write-Cherry-Pick-Command <the MR to cherrypick>
function Create-MR($MR_ID)
{
    $original_info = Get-MRInfo $MR_ID;
    $target_branch = "dev/V11.3.2";
    $target_branch = [System.Web.HttpUtility]::UrlEncode($target_branch)
    echo "Target Branch: $target_branch"
    $source_branch = Get-SourceBranchName $original_info;
    $source_branch = [System.Web.HttpUtility]::UrlEncode($source_branch);
    echo "Source Brance: $source_branch"
    $title = Get-Title $original_info;
    $title = [System.Web.HttpUtility]::UrlEncode($title)
    echo "Title: $title"
    $description = Get-Description $original_info;
    $description = [System.Web.HttpUtility]::UrlEncode($description)
    echo "Descritpion: $description"

    # $combined = 
    #     "$script:server_URL/api/v4/projects/60/merge_requests" + `
    #     "?source_branch=$source_branch" + `
    #     "&target_branch=$target_branch" + `
    #     "&title=$title" + `
    #     "&reviewer_ids=25,107,110,135" + `
    #     "&assignee_id=16" + `
    #     "&description=$description"

    curl --verbose -X POST --header "PRIVATE-TOKEN: $script:TOKEN" `
        $("$script:server_URL/api/v4/projects/60/merge_requests/" + `
        "?source_branch=$source_branch" + `
        "&target_branch=$target_branch" + `
        "&title=$title" + `
        "&reviewer_ids=26,107,110,135" + `
        "&assignee_id=16" + `
        "&description=$description" + `
        "&remove_source_branch=true" + `
        "&squash=true")
}

function Gitlab-Set-Reviewers($MR_ID)
{
    curl --verbose -X PUT --header "PRIVATE-TOKEN: $script:TOKEN" `
        $("$script:server_URL/api/v4/projects/60/merge_requests/$MR_ID" + `
        "?assignee_id=16" + `
        "&reviewer_ids=26,107,110,135")
}
