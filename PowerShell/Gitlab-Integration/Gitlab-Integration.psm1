$script:TOKEN = "<the token>"
$script:server_URL = "The gitlab server"

enum ProjectId {
    WbmsGUI = 60
    WbmFile = 355
    RotatorAPI = 339
    RotatorIPosWrapp = 808
    Tss1MessagingLib = 353
    ApplanixGrpParser = 194
}

function Set-Reviewers
{
    param(
        [Parameter(mandatory)]
        [int]$MR = $(throw "-MR id is requires"),

        [ProjectId]$Project = [ProjectId]::WbmsGUI,

        [ValidateSet(16)]
        [int]$Assignee = 16     # Me
    )

    # Users:
    # 16 = Me
    # 26 = Liney
    # 107 = Adrian
    # 110 = Jozef
    # 224 = Atilla
    # 295 = Laszlo
    curl --verbose -X PUT --header "PRIVATE-TOKEN: $script:TOKEN" `
        $("$script:server_URL/api/v4/projects/$([int]$Project)/merge_requests/$MR" + `
        "?assignee_id=$Assignee" + `
        "&reviewer_ids=26,107,110,224,295")
}
