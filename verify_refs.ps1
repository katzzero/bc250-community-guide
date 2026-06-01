<#
.SYNOPSIS
  Verify external references in Revised/ markdown files are valid and contextualized.
.DESCRIPTION
  Checks:
    1. All curl/wget to raw.githubusercontent.com URLs return HTTP 200
    2. All git clone URLs reference existing repos
    3. All ./scripts/ references have a clear repo context nearby
    4. All GitHub repo references (user/repo) are valid repos
#>

$ErrorActionPreference = "Continue"
$Revised = $PSScriptRoot
$results = @{ ok = 0; warn = 0; err = 0 }
$lines = @()
$global:ghCache = @{}  # cache GitHub API results to avoid rate limiting

function Log($kind, $msg) {
    $results[$kind]++
    $prefix = @{ ok = "  OK"; warn = " WARN"; err = "ERROR" }[$kind]
    $lines += "$prefix  $msg"
    if ($kind -eq "err") { Write-Host "${prefix}: $msg" -ForegroundColor Red }
    elseif ($kind -eq "warn") { Write-Host "${prefix}: $msg" -ForegroundColor Yellow }
    else { Write-Host "${prefix}: $msg" -ForegroundColor Green }
}

# --- Helper: HEAD request with timeout ---
function Test-Url($url) {
    try {
        $req = [System.Net.WebRequest]::Create($url)
        $req.Method = "HEAD"
        $req.Timeout = 15000
        $req.UserAgent = "BC250-verify/1.0"
        $resp = $req.GetResponse()
        $code = [int]$resp.StatusCode
        $resp.Close()
        return $code -eq 200
    } catch {
        return $false
    }
}

# --- Helper: Check GitHub repo with caching ---
function Test-GitHubRepo($repo, $returnStatus = $false) {
    if ($global:ghCache.ContainsKey($repo)) {
        if ($returnStatus) { return $global:ghCache[$repo] }
        return ($global:ghCache[$repo] -eq "200")
    }
    $status = "error"
    try {
        $req = [System.Net.WebRequest]::Create("https://api.github.com/repos/$repo")
        $req.Method = "HEAD"
        $req.Timeout = 15000
        $req.UserAgent = "BC250-verify/1.0"
        $req.ContentType = "application/json"
        $resp = $req.GetResponse()
        $status = [string][int]$resp.StatusCode
        $resp.Close()
    } catch {
        if ($_.Exception.InnerException.Response) {
            $status = [string][int]$_.Exception.InnerException.Response.StatusCode
        } elseif ($_.Exception.Response) {
            $status = [string][int]$_.Exception.Response.StatusCode
        } else {
            $status = "error: $($_.Exception.Message)"
        }
    }
    $global:ghCache[$repo] = $status
    if ($returnStatus) { return $status }
    return ($status -eq "200")
}

# --- 1. Validate raw.githubusercontent.com URLs ---
Write-Host "`n=== 1. Validating raw.githubusercontent.com URLs ===`n" -ForegroundColor Cyan
$rawUrls = Select-String -Path "$Revised\*.md" -Pattern "https://raw\.githubusercontent\.com[^\s""'`$)]+" -AllMatches
foreach ($match in $rawUrls) {
    $url = $match.Matches.Value.TrimEnd(")", "`"", "'")
    $file = Split-Path $match.Path -Leaf
    $line = $match.LineNumber
    if (Test-Url $url) {
        Log "ok" "$file`:$line — $url"
    } else {
        Log "err" "$file`:$line — $url FAILED"
    }
}

# --- 2. Validate git clone URLs (GitHub only) ---
Write-Host "`n=== 2. Validating git clone URLs ===`n" -ForegroundColor Cyan
$cloneUrls = Select-String -Path "$Revised\*.md" -Pattern "git clone (https?://[^\s""'`$)]+)" -AllMatches
foreach ($match in $cloneUrls) {
    $url = $null
    $file = Split-Path $match.Path -Leaf
    $line = $match.LineNumber
    $urlRaw = $match.Matches.Groups[1].Value
    $url = $urlRaw -replace '\.git$', '' -replace '\)$', ''

    # Only check GitHub repos
    if ($url -match "github\.com/([\w.-]+/[\w.-]+)") {
        $repo = $matches[1] -replace '\.git$', ''
        $ghStatus = Test-GitHubRepo $repo $true
        if ($ghStatus -eq "200") {
            Log "ok" "$file`:$line — $repo"
        } elseif ($ghStatus -eq "404") {
            Log "err" "$file`:$line — $repo NOT FOUND (404)"
        } else {
            Log "warn" "$file`:$line — $repo ($ghStatus)"
        }
    } else {
        Log "warn" "$file`:$line — (non-GitHub, skipped)"
    }
}

# --- 3. Check that every ./scripts/ reference has a clear repo context nearby ---
Write-Host "`n=== 3. Checking ./scripts/ context ===`n" -ForegroundColor Cyan
$scriptRefs = Select-String -Path "$Revised\*.md" -Pattern "\./scripts/" -AllMatches
foreach ($match in $scriptRefs) {
    $file = Split-Path $match.Path -Leaf
    $lineNo = $match.LineNumber
    $text   = $match.Line.Trim()
    $ctx    = Get-Content $match.Path | Select-Object -First $lineNo

    # Look for relevant context before this line
    $cloneUpTo = $ctx | Select-String "git clone" | Select-Object -Last 1
    $cdUpTo    = $ctx | Select-String "^cd " | Select-Object -Last 1
    $headingUpTo = $ctx | Select-String "^#{1,4} " | Select-Object -Last 1

    $contextOk = $false

    # Check if a "cd <repo-dir>" exists within 5 lines before this reference
    if ($cdUpTo) {
        $cdDist = $lineNo - $cdUpTo.LineNumber
        if ($cdDist -ge 0 -and $cdDist -le 5) { $contextOk = $true }
    }

    # Check if heading explicitly names the repo
    if (-not $contextOk -and $headingUpTo) {
        $hText = $headingUpTo.Line
        $hDist = $lineNo - $headingUpTo.LineNumber
        if ($hDist -le 20 -and $hText -match "duggasco|kernel patch") { $contextOk = $true }
    }

    # Check if the 3 lines before this line mention "duggasco" or "cd "
    if (-not $contextOk -and $lineNo -ge 4) {
        $nearby = Get-Content $match.Path | Select-Object -Index (($lineNo-3)..$lineNo)
        if ($nearby -match "duggasco|cd ") { $contextOk = $true }
    }

    if ($contextOk) {
        Log "ok" "$file`:$lineNo — $text"
    } else {
        Log "err" "$file`:$lineNo — $text (NO clear repo context!)"
    }
}

# --- 4. Validate all GitHub repo references ---
Write-Host "`n=== 4. Checking GitHub repo references ===`n" -ForegroundColor Cyan
$repoRefs = Select-String -Path "$Revised\*.md" -Pattern "github\.com/([\w.-]+/[\w.-]+)" -AllMatches
$checked = @{}
$errors = @()
$delay = 0
foreach ($match in $repoRefs) {
    $repo = $match.Matches.Groups[1].Value -replace '\.git$', ''
    if ($checked[$repo]) { continue }
    $checked[$repo] = $true

    # Small delay between requests to avoid rate limiting
    if ($delay -gt 0) { Start-Sleep -Milliseconds $delay }
    $delay = 150
    $ghStatus = Test-GitHubRepo $repo $true
    if ($ghStatus -eq "200") {
        Log "ok" "$repo"
    } elseif ($ghStatus -eq "404") {
        Log "err" "$repo — NOT FOUND (404)"
        $errors += $repo
    } else {
        Log "err" "$repo — $ghStatus (API limit or network error)"
    }
}

if ($errors.Count -gt 0) {
    Write-Host "`nPotentially stale repos:" -ForegroundColor Yellow
    foreach ($e in $errors) {
        Write-Host "  https://github.com/$e" -ForegroundColor Yellow
    }
}

# --- Summary ---
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SUMMARY: $($results.ok) OK / $($results.warn) WARN / $($results.err) ERR" -ForegroundColor Cyan
if ($results.err -gt 0) { exit 1 }
