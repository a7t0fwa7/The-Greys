#Requires -Version 5.1
<#
.SYNOPSIS
    BYOPH Series - PowerShell Hunting Queries

.DESCRIPTION
    Collection of hunting queries for detecting suspicious protocol handlers.
    Part of the BYOPH (Bring Your Own Protocol Handler) detection series.

.NOTES
    Author: Mr.b3d0u55i (a7t0fwa7)
    License: MIT License
    Copyright (c) 2026 Mr.b3d0u55i (a7t0fwa7)
    Source: https://github.com/a7t0fwa7/The-Greys
    Purpose: Educational/Detection

.LICENSE
    Licensed under the MIT License.
    See LICENSE-CODE file in the repository root for full license text.

.WARNING
    Run in isolated test environments first!
    For educational and authorized security testing purposes only.
#>

#region ===== QUERY 1: List All Protocol Handlers (HKCU) =====

Write-Host "`n[*] Query 1: All Protocol Handlers for Current User" -ForegroundColor Cyan
Write-Host "=" * 60

$hkcuHandlers = Get-ChildItem "HKCU:\Software\Classes" -ErrorAction SilentlyContinue | 
    Where-Object { 
        $props = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue
        $props.PSObject.Properties.Name -contains "URL Protocol"
    } | ForEach-Object {
        $cmd = Get-ItemProperty "$($_.PSPath)\shell\open\command" -ErrorAction SilentlyContinue
        [PSCustomObject]@{
            Scheme    = $_.PSChildName
            Command   = $cmd.'(Default)'
            Path      = $_.PSPath -replace 'Microsoft.PowerShell.Core\\Registry::', ''
        }
    }

$hkcuHandlers | Format-Table -AutoSize -Wrap
Write-Host "Total HKCU handlers: $($hkcuHandlers.Count)" -ForegroundColor Yellow

#endregion

#region ===== QUERY 2: Find Suspicious Commands =====

Write-Host "`n[*] Query 2: Handlers with Suspicious Commands" -ForegroundColor Cyan
Write-Host "=" * 60

$suspiciousKeywords = @(
    'powershell', 'pwsh', 'cmd.exe', 'mshta', 'wscript', 'cscript',
    'rundll32', 'regsvr32', 'certutil', 'bitsadmin', 'msiexec',
    'http://', 'https://', 'ftp://'
)

$suspiciousHandlers = $hkcuHandlers | Where-Object {
    $command = $_.Command
    $suspiciousKeywords | Where-Object { $command -match $_ }
}

if ($suspiciousHandlers) {
    Write-Host "[!] SUSPICIOUS HANDLERS FOUND:" -ForegroundColor Red
    $suspiciousHandlers | Format-Table -AutoSize -Wrap
} else {
    Write-Host "[+] No suspicious handlers detected" -ForegroundColor Green
}

#endregion

#region ===== QUERY 3: Handlers in User-Writable Locations =====

Write-Host "`n[*] Query 3: Handlers Pointing to User-Writable Paths" -ForegroundColor Cyan
Write-Host "=" * 60

$userPaths = @('\Users\', '\AppData\', '\Temp\', '\Downloads\', '\Desktop\')

$userPathHandlers = $hkcuHandlers | Where-Object {
    $command = $_.Command
    $userPaths | Where-Object { $command -match [regex]::Escape($_) }
}

if ($userPathHandlers) {
    Write-Host "[!] HANDLERS IN USER PATHS:" -ForegroundColor Yellow
    $userPathHandlers | Format-Table -AutoSize -Wrap
} else {
    Write-Host "[+] No handlers in user-writable paths" -ForegroundColor Green
}

#endregion

#region ===== QUERY 4: Compare HKCU vs HKLM (Shadowing Detection) =====

Write-Host "`n[*] Query 4: Potential Handler Shadowing (HKCU overriding HKLM)" -ForegroundColor Cyan
Write-Host "=" * 60

$hklmSchemes = Get-ChildItem "HKLM:\SOFTWARE\Classes" -ErrorAction SilentlyContinue | 
    Where-Object { 
        $props = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue
        $props.PSObject.Properties.Name -contains "URL Protocol"
    } | Select-Object -ExpandProperty PSChildName

$shadowedHandlers = $hkcuHandlers | Where-Object {
    $hklmSchemes -contains $_.Scheme
}

if ($shadowedHandlers) {
    Write-Host "[!] POTENTIAL SHADOWING DETECTED:" -ForegroundColor Red
    Write-Host "These HKCU handlers override HKLM handlers with same name:" -ForegroundColor Yellow
    $shadowedHandlers | Format-Table -AutoSize -Wrap
} else {
    Write-Host "[+] No handler shadowing detected" -ForegroundColor Green
}

#endregion

#region ===== QUERY 5: Export for Analysis =====

Write-Host "`n[*] Query 5: Export All Handlers to CSV" -ForegroundColor Cyan
Write-Host "=" * 60

$exportPath = Join-Path $env:TEMP "byoph_handlers_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$hkcuHandlers | Export-Csv -Path $exportPath -NoTypeInformation

Write-Host "[+] Exported to: $exportPath" -ForegroundColor Green

#endregion

#region ===== QUERY 6: Quick Registry Command =====

Write-Host "`n[*] Query 6: Quick Command-Line Check" -ForegroundColor Cyan
Write-Host "=" * 60
Write-Host "Run this command for a quick check:" -ForegroundColor Yellow
Write-Host 'reg query "HKCU\Software\Classes" /s /f "URL Protocol"' -ForegroundColor White

#endregion

Write-Host "`n[*] Hunting Complete" -ForegroundColor Green
Write-Host "Remember: Always investigate suspicious findings in isolated environments!" -ForegroundColor Yellow

