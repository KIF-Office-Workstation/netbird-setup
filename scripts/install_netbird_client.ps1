# NetBird Windows Client Automated Installer Script
# Target OS: Windows 10 Pro (x64)
# Repository: KIF-Office-Workstation/netbird-setup

[CmdletBinding()]
param (
    [string]$SetupKey = "",
    [string]$ManagementUrl = "",
    [switch]$InspectOnly
)

$ErrorActionPreference = "Stop"

Write-Host "======================================================" -ForegroundColor Cyan
Write-Host " NetBird Windows Client Installation & Setup Utility  " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan

# 1. Environment & Pre-installation Diagnostics
Write-Host "`n[1/4] Running pre-installation host diagnostics..." -ForegroundColor Yellow

$ExistingService = Get-Service -Name "NetBird" -ErrorAction SilentlyContinue
if ($ExistingService) {
    Write-Host " -> NetBird Service Found! Status: $($ExistingService.Status)" -ForegroundColor Green
} else {
    Write-Host " -> NetBird Service is NOT currently installed." -ForegroundColor Gray
}

$NetBirdCmd = Get-Command netbird -ErrorAction SilentlyContinue
if ($NetBirdCmd) {
    $VersionOutput = netbird version
    Write-Host " -> NetBird CLI Found at: $($NetBirdCmd.Source)" -ForegroundColor Green
    Write-Host " -> Installed Version: $VersionOutput" -ForegroundColor Green
} else {
    Write-Host " -> NetBird CLI binary is NOT in system PATH." -ForegroundColor Gray
}

if ($InspectOnly) {
    Write-Host "`n[INSPECT MODE] Host inspection complete. No changes made." -ForegroundColor Cyan
    exit 0
}

# 2. Download Official NetBird Windows Installer if missing
Write-Host "`n[2/4] Verifying official NetBird Windows installer package..." -ForegroundColor Yellow

$WorkDir = "$env:TEMP\NetBirdSetup"
if (!(Test-Path $WorkDir)) {
    New-Item -ItemType Directory -Force -Path $WorkDir | Out-Null
}

$OfficialDownloadUrl = "https://github.com/netbirdio/netbird/releases/download/v0.75.1/netbird_installer_0.75.1_windows_amd64.exe"
$InstallerPath = "$WorkDir\netbird_installer_0.75.1_windows_amd64.exe"

if (!(Test-Path $InstallerPath)) {
    Write-Host " -> Downloading official NetBird installer from release v0.75.1..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $OfficialDownloadUrl -OutFile $InstallerPath -UseBasicParsing
    Write-Host " -> Download complete: $InstallerPath" -ForegroundColor Green
} else {
    Write-Host " -> Installer executable verified locally: $InstallerPath" -ForegroundColor Green
}

# 3. Execute Silent Windows Installation
Write-Host "`n[3/4] Executing NetBird silent installation..." -ForegroundColor Yellow
Start-Process -FilePath $InstallerPath -ArgumentList "/S" -Wait

# 4. Service Verification & Startup Registration
Write-Host "`n[4/4] Verifying Windows NetBird Service status..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

$InstalledService = Get-Service -Name "NetBird" -ErrorAction SilentlyContinue
if ($InstalledService) {
    Set-Service -Name "NetBird" -StartupType Automatic
    if ($InstalledService.Status -ne "Running") {
        Start-Service -Name "NetBird"
    }
    Write-Host " -> NetBird Service Status: Running (Startup: Automatic)" -ForegroundColor Green
} else {
    Write-Host " -> WARNING: NetBird Service registration pending. Please check Event Viewer." -ForegroundColor Red
}

# 5. Handle Device Registration if Setup Key provided
if ($SetupKey -ne "") {
    Write-Host "`n[5/5] Registering device with provided Setup Key..." -ForegroundColor Yellow
    if ($ManagementUrl -ne "") {
        netbird up --setup-key $SetupKey --management-url $ManagementUrl
    } else {
        netbird up --setup-key $SetupKey
    }
} else {
    Write-Host "`n[NEXT STEP] Run 'netbird up --setup-key <YOUR_KEY>' or launch NetBird GUI to complete authentication." -ForegroundColor Cyan
}

Write-Host "`n======================================================" -ForegroundColor Cyan
Write-Host " NetBird Windows Client Setup Complete!               " -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
