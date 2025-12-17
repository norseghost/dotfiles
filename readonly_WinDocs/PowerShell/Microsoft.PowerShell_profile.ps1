Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key UpArrow -Function PreviousHistory
Set-PSReadLineKeyHandler -Key DownArrow -Function NextHistory
if (Get-Command Set-PsFzfOption -ErrorAction SilentlyContinue) {
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
}
$docs = [Environment]::GetFolderPath('MyDocuments')
$zoxideCache = Join-Path $docs "PowerShell\.zoxide.ps1"

if (-not (Test-Path $zoxideCache)) {
    if (Get-Command zoxide -ErrorAction SilentlyContinue) {
# Ensure directory exists before writing
        $cacheDir = Split-Path $zoxideCache
            if (-not (Test-Path $cacheDir)) { New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null }

        zoxide init powershell > $zoxideCache
    }
}

if (Test-Path $zoxideCache) { . $zoxideCache }
function prompt {
    $esc = "`e"
    $Reset = "$esc[0m"
    $Green = "$esc[32m"
    $Yellow = "$esc[33m"
    $Cyan = "$esc[36m"

    # 1. Fast Path calculation
    $CurrentPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    $pathComponents = $CurrentPath.Split([System.IO.Path]::DirectorySeparatorChar)
    
    if ($pathComponents.Count -le 3) {
        $DisplayPath = $CurrentPath
    } else {
        $DisplayPath = "$($pathComponents[0])\...\$($pathComponents[-2])\$($pathComponents[-1])"
    }

    # 2. Git Logic
    $GitSegment = ""
    # Only run git if we are likely in a repo to save process cycles
    if (Test-Path .git -PathType Container) {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($branch) {
            $GitSegment = " [$Yellow$branch$Reset]"
            
            # Get status short-form: M = modified, A = added, D = deleted
            # --cached includes staged changes; remove it if you only want unstaged
            $stats = git diff-index --name-status HEAD 2>$null
            
            if ($stats) {
                # Efficiency: Count occurrences in the string without regex overhead
                $mCount = ($stats | Select-String -Pattern "^M" -AllMatches).Matches.Count
                $aCount = ($stats | Select-String -Pattern "^A" -AllMatches).Matches.Count
                $dCount = ($stats | Select-String -Pattern "^D" -AllMatches).Matches.Count

                if ($mCount -gt 0) { $GitSegment += " ${Cyan}u:$mCount$Reset" }
                if ($aCount -gt 0) { $GitSegment += " ${Green}c:$aCount$Reset" }
                if ($dCount -gt 0) { $GitSegment += " ${Red}d:$dCount$Reset" }
            }
        }
    }

    # 3. Output
    Write-Host "$DisplayPath$GitSegment" -NoNewline
    Write-Output "`n$Green>$Reset "
}

