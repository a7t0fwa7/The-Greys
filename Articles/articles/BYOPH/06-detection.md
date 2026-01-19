# Article 6: Hunting BYOPH

## Detection Rules, Sigma, and Sysmon

**Series:** Decoding BYOPH (Part 6 of 7)
**Reading time:** 8 minutes
**Skill level:** Intermediate to Advanced

---

## 📝 LinkedIn Post Content

Now that you understand how BYOPH works, let's switch fully to the blue team perspective. Today: detection rules, Sysmon configuration, and incident response procedures.

Time to hunt these protocol handlers in your environment.

---

### 🎯 What You'll Learn Today

✅ Create detection rules for SIEM/EDR platforms
✅ Configure Sysmon for protocol handler monitoring
✅ Build a Sigma rule for BYOPH detection
✅ Perform incident response on malicious handlers
✅ Establish a baseline and hunting strategy

---

### 🛡️ Defense Strategy Overview

Defense against BYOPH requires multiple layers:

```
PREVENTION                    DETECTION                     RESPONSE
├── Block .reg imports        ├── Registry monitoring       ├── Export evidence
├── Application control       ├── Process monitoring        ├── Delete handler
├── User training             ├── Network monitoring        ├── Hunt for execution
└── Least privilege           └── Baseline comparison       └── Lateral movement check
```

---

### 📍 What to Monitor

**Registry Locations:**
```
HKCU\Software\Classes\*          ← Primary attack vector
HKLM\SOFTWARE\Classes\*          ← Secondary (needs admin)
```

**Specific Indicators:**
| Indicator | Why It Matters |
|-----------|----------------|
| New scheme keys | Fresh handler registration |
| `URL Protocol` value | Marks key as URL handler |
| `shell\open\command` changes | Execution payload modified |
| Suspicious executables | powershell, cmd, mshta, etc. |
| Network strings in commands | http://, IP addresses |

---

### 📊 Sigma Rule for BYOPH Detection

Here's a production-ready Sigma rule:

```yaml
title: Suspicious Protocol Handler Registration
id: a1b2c3d4-e5f6-7890-abcd-ef1234567890
status: experimental
description: Detects registration of URL protocol handlers with suspicious commands
author: Security Team
date: 2024/01/15
references:
    - https://attack.mitre.org/techniques/T1218/
logsource:
    product: windows
    category: registry_set
detection:
    selection_path:
        TargetObject|contains: '\Software\Classes\'
        TargetObject|endswith: '\shell\open\command'
    selection_suspicious:
        Details|contains:
            - 'powershell'
            - 'cmd.exe'
            - 'mshta'
            - 'wscript'
            - 'cscript'
            - 'rundll32'
            - 'regsvr32'
            - 'certutil'
            - 'bitsadmin'
    selection_network:
        Details|contains:
            - 'http://'
            - 'https://'
            - 'ftp://'
    condition: selection_path and (selection_suspicious or selection_network)
falsepositives:
    - Legitimate software installation
    - IT automation scripts
level: high
tags:
    - attack.execution
    - attack.persistence
```

---

### 🔧 Sysmon Configuration

Add this to your Sysmon config to capture protocol handler activity:

```xml
<Sysmon schemaversion="4.90">
  <EventFiltering>
    <!-- Protocol Handler Registration -->
    <RuleGroup name="Protocol Handler Monitoring" groupRelation="or">
      <RegistryEvent onmatch="include">
        <TargetObject condition="contains">\Software\Classes\</TargetObject>
        <TargetObject condition="contains">\shell\open\command</TargetObject>
      </RegistryEvent>
      <RegistryEvent onmatch="include">
        <TargetObject condition="contains">\Software\Classes\</TargetObject>
        <Details condition="is">URL Protocol</Details>
      </RegistryEvent>
    </RuleGroup>
    
    <!-- Process Creation from Browsers -->
    <RuleGroup name="Browser Child Processes" groupRelation="or">
      <ProcessCreate onmatch="include">
        <ParentImage condition="end with">chrome.exe</ParentImage>
        <ParentImage condition="end with">msedge.exe</ParentImage>
        <ParentImage condition="end with">firefox.exe</ParentImage>
      </ProcessCreate>
    </RuleGroup>
  </EventFiltering>
</Sysmon>
```

**Key events to collect:**
• Event ID 12/13/14: Registry operations
• Event ID 1: Process creation (for handler execution)

---

### 🔍 Hunting Queries

**PowerShell - Find Suspicious Handlers:**
```powershell
# Get all protocol handlers for current user
Get-ChildItem "HKCU:\Software\Classes" | 
Where-Object { 
    (Get-ItemProperty $_.PSPath -Name "URL Protocol" -ErrorAction SilentlyContinue)
} | ForEach-Object {
    $cmd = Get-ItemProperty "$($_.PSPath)\shell\open\command" -ErrorAction SilentlyContinue
    [PSCustomObject]@{
        Scheme = $_.PSChildName
        Command = $cmd.'(Default)'
    }
} | Where-Object { 
    $_.Command -match 'powershell|cmd\.exe|mshta|wscript|http'
}
```

**Command Line - Quick Check:**
```batch
reg query "HKCU\Software\Classes" /s /f "URL Protocol"
```

---

### 🚨 Incident Response Playbook

When you find a suspicious handler:

**Step 1: Preserve Evidence**
```batch
reg export "HKCU\Software\Classes\suspicious-scheme" C:\Evidence\handler.reg
```

**Step 2: Document**
• Screenshot registry structure
• Record full command value
• Note discovery timestamp
• Identify affected user(s)

**Step 3: Analyze the Command**
• What executable?
• Network indicators?
• File paths referenced?
• Obfuscation techniques?

**Step 4: Hunt for Execution**
• Search process logs for handler executable
• Check for network connections to identified IPs/domains
• Look for files written to staging directories

**Step 5: Remediate**
```batch
reg delete "HKCU\Software\Classes\suspicious-scheme" /f
```

**Step 6: Hunt Laterally**
• Did other users receive the .reg file?
• Were similar handlers registered on other systems?
• Check email logs for delivery vector

---

### 📈 Baseline Strategy

**Build a whitelist:**
1. Enumerate all protocol handlers in your environment
2. Document legitimate business schemes
3. Alert on new schemes not in baseline

**Sample baseline command:**
```powershell
# Export baseline
Get-ChildItem "HKCU:\Software\Classes" | 
Where-Object { Get-ItemProperty $_.PSPath -Name "URL Protocol" -EA 0 } |
Select-Object PSChildName | 
Export-Csv "baseline_handlers.csv"
```

---

### 📌 Key Takeaways

1. **Registry monitoring is essential**—capture writes to `\Software\Classes\`
2. **Use Sigma rules** for cross-platform detection
3. **Sysmon provides rich telemetry**—configure it specifically for BYOPH
4. **Baseline your environment**—know what's normal to spot what's not
5. **IR playbook ready**—document procedures before you need them

---

### ⚠️ OPERATIONAL NOTE

```
Test all detection rules in non-production first!

✓ Validate Sigma rules against your SIEM
✓ Test Sysmon config for performance impact
✓ Tune for your environment's false positive rate
✓ Document baseline exceptions

These rules are starting points—customize for your environment.
```

---

### 🔜 Coming Next Week (Series Finale!)

In Part 7, we explore what **advanced attackers do differently**—OPSEC techniques, LOLBins, and custom handlers that evade basic detection. Plus, how to adapt your defenses.

**Follow me** for the finale!

---

### 💬 Discussion Question

What's your current visibility into protocol handler registration? Do you monitor HKCU changes?

---

#Cybersecurity #BlueTeam #ThreatHunting #Sigma #Sysmon #BYOPH #Detection #IncidentResponse #SOC #SecurityOperations

