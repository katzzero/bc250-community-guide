<#
.SYNOPSIS
    Synchronizes Revised/ markdown files to the wiki/ directory.

.DESCRIPTION
    Copies numbered guide files, changelog, and contributing docs from Revised/ to wiki/.
    Excludes README.md (repo-specific) and LICENSE. Preserves wiki-specific files (_Sidebar.md, _Footer.md, Home.md).

.EXAMPLE
    .\sync-wiki.ps1
    .\sync-wiki.ps1 -WhatIf
#>

[CmdletBinding(SupportsShouldProcess)]
param()

$RevisedPath = Join-Path $PSScriptRoot "."
$WikiPath = Join-Path $PSScriptRoot "..\wiki"

if (-not (Test-Path $WikiPath)) {
    Write-Error "Wiki directory not found at: $WikiPath"
    exit 1
}

$filesToSync = @(
    "00-from-zero-to-gaming.md",
    "01-hardware-specs.md",
    "02-bios-and-firmware.md",
    "03-power-supply-guide.md",
    "04-cooling-guide.md",
    "05-os-installation.md",
    "06-gpu-governor.md",
    "07-game-benchmarks.md",
    "08-display-and-audio.md",
    "09-wifi-and-peripherals.md",
    "10-troubleshooting.md",
    "11-community-and-resources.md",
    "12-ai-inference.md",
    "13-case-mods.md",
    "changelog.md",
    "CONTRIBUTING.md"
)

$synced = 0
$skipped = 0

foreach ($file in $filesToSync) {
    $source = Join-Path $RevisedPath $file
    $dest = Join-Path $WikiPath $file

    if (-not (Test-Path $source)) {
        Write-Warning "Source not found, skipping: $file"
        $skipped++
        continue
    }

    $sourceHash = (Get-FileHash $source -Algorithm MD5).Hash
    $destHash = if (Test-Path $dest) { (Get-FileHash $dest -Algorithm MD5).Hash } else { $null }

    if ($sourceHash -eq $destHash) {
        Write-Verbose "Up-to-date: $file"
        $skipped++
        continue
    }

    if ($PSCmdlet.ShouldProcess($file, "Sync to wiki")) {
        Copy-Item -Path $source -Destination $dest -Force
        Write-Host "Synced: $file"
        $synced++
    }
}

Write-Host ""
Write-Host "Sync complete: $synced file(s) updated, $skipped file(s) unchanged."

if ($synced -gt 0) {
    Write-Host ""
    Write-Host "Next steps:"
    Write-Host "  cd ..\wiki"
    Write-Host "  git add -A"
    Write-Host '  git commit -m "Sync wiki with Revised docs"'
    Write-Host "  git push"
}
