# Pushes the 2026 broadcast-audit fixes to origin/main (GitHub Pages).
# Run from PowerShell:   .\PUSH_2026_AUDIT.ps1
# Or right-click -> Run with PowerShell.
# If you get an execution policy error, run once:
#   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned

$ErrorActionPreference = 'Continue'
$RepoPath = 'C:\Users\Billy\Desktop\Superdev\BBProjectDevelopment\WhatChannelAreTheYankeesOn'
$LogPath  = Join-Path $RepoPath 'PUSH_2026_AUDIT.log'

Set-Location -LiteralPath $RepoPath

"=== PUSH_2026_AUDIT.ps1 run $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') ===" | Out-File -FilePath $LogPath -Encoding utf8

function Log {
    param([string]$Message)
    $Message | Tee-Object -FilePath $LogPath -Append | Out-Host
}

function Run-Git {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$GitArgs)
    Log "PS> git $($GitArgs -join ' ')"
    & git @GitArgs 2>&1 | Tee-Object -FilePath $LogPath -Append | Out-Host
}

# [1] Clear stale lock files left behind by interrupted git operations.
Log "[1] Clearing stale lock files"
$locks = @(
    '.git\index.lock',
    '.git\HEAD.lock',
    '.git\objects\maintenance.lock',
    '.git\refs\heads\main.lock'
)
foreach ($lock in $locks) {
    $full = Join-Path $RepoPath $lock
    if (Test-Path -LiteralPath $full) {
        try {
            Remove-Item -LiteralPath $full -Force -ErrorAction Stop
            Log "    removed $lock"
        } catch {
            Log "    WARN: could not remove $lock - $($_.Exception.Message)"
        }
    }
}
Get-ChildItem -LiteralPath (Join-Path $RepoPath '.git\objects') -Recurse -Filter 'tmp_obj_*' -ErrorAction SilentlyContinue |
    ForEach-Object {
        try { Remove-Item -LiteralPath $_.FullName -Force -ErrorAction Stop; Log "    removed tmp object $($_.Name)" }
        catch { Log "    WARN: could not remove $($_.Name)" }
    }

# [2] Fetch latest origin/main
Log "[2] Fetching latest origin/main"
Run-Git fetch origin main

# [3] Reset local main to origin/main while keeping working tree
Log "[3] Resetting --mixed to origin/main (keeps working tree)"
Run-Git reset --mixed origin/main

# [4] Stage only index.html (the file with the 2026 audit fixes)
Log "[4] Staging only index.html"
Run-Git add index.html

# [5] Status snapshot before commit
Log "[5] Status before commit"
Run-Git status --short

# [6] Commit
Log "[6] Committing"
$commitMessage = '2026 broadcast audit: NBC/Peacock SNB, Netflix events, Apple TV paid; fix NBCSN filter bug + add WEB/Streaming types; Rate Field, Athletics/Sutter Health Park; JSON-LD SportsEvent schema, noscript fallback, og:image absolute URL, robots meta; widen offseason fallback; misc polish'
Run-Git commit -m $commitMessage

# [7] Push
Log "[7] Pushing to origin/main"
Run-Git push origin main

# [8] Final state
Log "[8] Final state"
Run-Git log --oneline -3

Log "=== Done. Full output in PUSH_2026_AUDIT.log ==="
