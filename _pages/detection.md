---
layout: default
title: Detection Rules
permalink: /detection/
---

# 🔍 Detection Rules & Threat Hunting

Blue team resources for detecting and responding to Windows protocol handler attacks.

---

## 🎯 Detection Strategy

A comprehensive detection strategy should include:

1. **Registry Monitoring** - Detect new handler registrations
2. **Process Monitoring** - Identify suspicious handler executions
3. **Network Monitoring** - Catch handlers making network connections
4. **Behavioral Analysis** - Detect anomalous handler behavior

---

## 📊 Detection Resources

### 🔴 Sigma Rules

SIEM-agnostic detection rules for protocol handler attacks.

[Download Sigma Rules](../Articles/github-readme/BYOPH/samples/detection/byoph_detection.yml)

**Included Rules:**
- Suspicious protocol handler registration
- Handlers with PowerShell/CMD commands
- Handlers in user-writable locations
- Handlers with network indicators
- Obfuscated handler commands

**Supported SIEMs:**
- Splunk
- Elastic
- QRadar
- ArcSight
- Microsoft Sentinel

**Usage:**
```bash
# Convert to Splunk
sigmac -t splunk byoph_detection.yml

# Convert to Elastic
sigmac -t es-qs byoph_detection.yml

# Convert to Microsoft Sentinel
sigmac -t ala byoph_detection.yml
```

---

### 🔧 Sysmon Configuration

Enhanced Sysmon configuration for protocol handler monitoring.

[Download Sysmon Config](../Articles/github-readme/BYOPH/samples/detection/byoph_sysmon_config.xml)

**Monitored Events:**
- **Event ID 13:** Registry value set (handler registration)
- **Event ID 1:** Process creation (handler execution)
- **Event ID 3:** Network connection (handler C2 communication)

**Installation:**
```powershell
# Install Sysmon with BYOPH config
sysmon64.exe -accepteula -i byoph_sysmon_config.xml

# Update existing Sysmon config
sysmon64.exe -c byoph_sysmon_config.xml
```

**Merge with Existing Config:**
```xml
<!-- Add BYOPH rules to your existing Sysmon config -->
<!-- Copy the relevant <Rule> sections -->
```

---

### 💻 PowerShell Hunting Queries

Interactive threat hunting scripts for finding malicious handlers.

[Download Hunting Queries](../Articles/github-readme/BYOPH/samples/detection/hunting_queries.ps1)

**Included Queries:**

#### Query 1: List All Protocol Handlers (HKCU)
```powershell
Get-ChildItem "HKCU:\Software\Classes" | 
    Where-Object { 
        $props = Get-ItemProperty $_.PSPath -ErrorAction SilentlyContinue
        $props.PSObject.Properties.Name -contains "URL Protocol"
    }
```

#### Query 2: Find Suspicious Commands
```powershell
# Detects handlers using PowerShell, CMD, MSHTA, etc.
$suspiciousKeywords = @('powershell', 'cmd.exe', 'mshta', 'wscript')
# See full script for complete implementation
```

#### Query 3: Handlers in User-Writable Locations
```powershell
# Finds handlers pointing to AppData, Temp, Downloads, etc.
$userPaths = @('\Users\', '\AppData\', '\Temp\', '\Downloads\')
# See full script for complete implementation
```

#### Query 4: Recently Modified Handlers
```powershell
# Finds handlers modified in the last 7 days
$cutoffDate = (Get-Date).AddDays(-7)
# See full script for complete implementation
```

#### Query 5: Export for Analysis
```powershell
# Export all handlers to CSV for offline analysis
$handlers | Export-Csv -Path "handlers_export.csv"
```

---

## 🎯 Quick Detection Commands

### Windows Command Line

```batch
REM List all HKCU protocol handlers
reg query "HKCU\Software\Classes" /s /f "URL Protocol"

REM List all HKLM protocol handlers
reg query "HKLM\SOFTWARE\Classes" /s /f "URL Protocol"

REM Check specific handler
reg query "HKCU\Software\Classes\sample\shell\open\command"
```

### PowerShell One-Liners

```powershell
# Count HKCU handlers
(Get-ChildItem "HKCU:\Software\Classes" | Where-Object { 
    (Get-ItemProperty $_.PSPath -EA 0).'URL Protocol' -ne $null 
}).Count

# Find handlers modified today
Get-ChildItem "HKCU:\Software\Classes" | Where-Object {
    $props = Get-ItemProperty $_.PSPath -EA 0
    $props.'URL Protocol' -ne $null -and 
    $_.LastWriteTime -gt (Get-Date).Date
}

# Export all handler commands
Get-ChildItem "HKCU:\Software\Classes" | Where-Object {
    (Get-ItemProperty $_.PSPath -EA 0).'URL Protocol' -ne $null
} | ForEach-Object {
    $cmd = Get-ItemProperty "$($_.PSPath)\shell\open\command" -EA 0
    [PSCustomObject]@{
        Handler = $_.PSChildName
        Command = $cmd.'(Default)'
    }
} | Format-Table -AutoSize
```

---

## 🚨 Indicators of Compromise (IoCs)

### Registry Indicators

**Suspicious Locations:**
- `HKCU\Software\Classes\<custom-scheme>`
- Handlers pointing to `%TEMP%`, `%APPDATA%`, `\Downloads\`

**Suspicious Commands:**
- `powershell.exe -enc`
- `cmd.exe /c curl http://...`
- `mshta.exe http://...`
- `rundll32.exe javascript:...`

### Process Indicators

**Suspicious Parent-Child Relationships:**
- `browser.exe` → `powershell.exe`
- `WINWORD.EXE` → `cmd.exe`
- `AcroRd32.exe` → `wscript.exe`

**Suspicious Command Lines:**
- Base64 encoded commands
- Network download commands
- Obfuscated scripts

---

## 📈 Baseline Your Environment

Before hunting for threats, establish a baseline:

```powershell
# Export current handlers
.\hunting_queries.ps1

# Review the output
# Document legitimate handlers
# Create allowlist for known-good handlers
```

**Common Legitimate Handlers:**
- `mailto:` - Email clients
- `tel:` - Phone applications
- `ms-teams:` - Microsoft Teams
- `zoom:` - Zoom meetings
- `slack:` - Slack application

---

## 🔬 Investigation Workflow

### Step 1: Detection
- Sigma rule triggers OR
- Hunting query finds suspicious handler

### Step 2: Triage
```powershell
# Get handler details
$handler = "suspicious-scheme"
Get-ItemProperty "HKCU:\Software\Classes\$handler\shell\open\command"

# Check when it was created
Get-Item "HKCU:\Software\Classes\$handler" | Select-Object LastWriteTime

# Check user context
whoami
```

### Step 3: Analysis
- Is the command legitimate?
- Is the executable signed?
- Is the path suspicious?
- When was it registered?
- Are there related artifacts?

### Step 4: Response
```powershell
# Isolate the system (if needed)
# Collect evidence
reg export "HKCU\Software\Classes\$handler" handler_backup.reg

# Remove the handler
reg delete "HKCU\Software\Classes\$handler" /f

# Verify removal
reg query "HKCU\Software\Classes\$handler"
```

### Step 5: Hunt for Lateral Movement
```powershell
# Check other systems for the same handler
# Use SCCM, PDQ, or other deployment tools
Invoke-Command -ComputerName (Get-ADComputer -Filter *).Name -ScriptBlock {
    Get-ItemProperty "HKCU:\Software\Classes\$using:handler\shell\open\command" -EA 0
}
```

---

## 📚 Additional Resources

- **[MITRE ATT&CK](https://attack.mitre.org/)** - T1547.001 (Boot or Logon Autostart Execution: Registry Run Keys)
- **[Sigma Rules Repository](https://github.com/SigmaHQ/sigma)** - Community detection rules
- **[Sysmon Documentation](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)** - Official Sysmon guide

---

[← Back to Home](../) | [Articles →](../articles/) | [Code Samples →](../samples/)

