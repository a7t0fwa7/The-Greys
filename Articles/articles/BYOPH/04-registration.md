# Article 4: HKCU vs HKLM

## Understanding Protocol Handler Persistence

**Series:** Decoding BYOPH (Part 4 of 7)
**Reading time:** 6 minutes
**Skill level:** Intermediate

---

## 📝 LinkedIn Post Content

There are two places you can register a protocol handler in Windows—and which one you choose changes everything from an attack and defense perspective.

Today we're diving into registry persistence and why HKCU is an attacker's best friend.

---

### 🎯 What You'll Learn Today

✅ The difference between HKCU and HKLM registration
✅ Why precedence rules matter for security
✅ How attackers leverage per-user registration
✅ What defenders should monitor

---

### 📍 The Two Registration Locations

Windows protocol handlers can live in two registry hives:

**HKEY_CURRENT_USER (HKCU)**
```
HKCU\Software\Classes\<scheme>
├── Scope: Current user only
├── Privileges: Standard user (no admin!)
├── Persistence: Survives reboots
└── Attack relevance: HIGH
```

**HKEY_LOCAL_MACHINE (HKLM)**
```
HKLM\SOFTWARE\Classes\<scheme>
├── Scope: All users on the system
├── Privileges: Administrator required
├── Persistence: System-wide, survives reboots
└── Attack relevance: Lower (needs admin)
```

---

### ⚔️ Why HKCU Is an Attacker's Best Friend

From an offensive perspective, HKCU registration is ideal:

| Factor | HKCU | HKLM |
|--------|------|------|
| Admin required | ❌ No | ✅ Yes |
| UAC bypass needed | ❌ No | ✅ Yes |
| Scope | Single user | All users |
| Stealth | Higher | Lower |
| Typical use | Attacks | Legitimate software |

**The key insight:** An attacker with standard user access can register a protocol handler that:
• Persists across reboots
• Executes code when invoked
• Requires no privilege escalation

---

### 🔄 The Precedence Rule (Critical!)

What happens if the same scheme exists in both HKCU and HKLM?

**HKCU WINS.**

This creates a dangerous scenario called **handler shadowing:**

```
Legitimate software installs:
HKLM\...\Classes\company-app → C:\Program Files\App\app.exe

Attacker registers:
HKCU\...\Classes\company-app → C:\Users\victim\malware.exe

User clicks company-app://
→ HKCU checked first
→ Malware executes instead of legitimate app!
```

**Defense implication:** Monitor HKCU for schemes that also exist in HKLM.

---

### 🛠️ Registration Methods

**Method 1: Registry Editor (Manual)**
1. Open `regedit.exe`
2. Navigate to `HKCU\Software\Classes`
3. Create key: `myscheme`
4. Add string value: `URL Protocol` = (empty)
5. Create: `myscheme\shell\open\command`
6. Set default to your command

**Method 2: .reg File Import**
```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\myscheme]
@="URL:My Scheme Protocol"
"URL Protocol"=""

[HKEY_CURRENT_USER\Software\Classes\myscheme\shell\open\command]
@="\"C:\\Path\\To\\Handler.exe\" \"%1\""
```

**Method 3: Command Line**
```batch
reg add "HKCU\Software\Classes\myscheme" /ve /d "URL:My Scheme" /f
reg add "HKCU\Software\Classes\myscheme" /v "URL Protocol" /d "" /f
reg add "HKCU\Software\Classes\myscheme\shell\open\command" /ve /d "\"C:\Path\Handler.exe\" \"%1\"" /f
```

---

### 🔍 What About HKEY_CLASSES_ROOT?

You'll often see `HKCR` (HKEY_CLASSES_ROOT) in documentation. Here's the truth:

**HKCR is not a real location.** It's a **merged view** of:
• `HKCU\Software\Classes` (per-user)
• `HKLM\SOFTWARE\Classes` (system)

When you read from HKCR:
→ HKCU entries take precedence

When you write to HKCR:
→ Actually writes to HKLM (needs admin)

**For hunting:** Check HKCU and HKLM separately. Don't rely on HKCR alone.

---

### 🛡️ Defense Strategies

**Monitor HKCU registrations:**
• New keys under `HKCU\Software\Classes\*`
• Presence of `URL Protocol` value
• Suspicious commands containing:
  - `powershell.exe`
  - `cmd.exe`
  - `mshta.exe`
  - Network indicators

**Detect handler shadowing:**
• Compare HKCU schemes against HKLM baseline
• Alert when user-level scheme matches system scheme

**Response actions:**
```batch
:: Export for evidence
reg export "HKCU\Software\Classes\suspicious" evidence.reg

:: Remove the handler
reg delete "HKCU\Software\Classes\suspicious" /f
```

---

### 🧪 Lab Exercise

Try this in your isolated VM:

1. Register a handler in HKLM (as admin) → Opens Notepad
2. Register same scheme in HKCU → Opens Calculator
3. Invoke the scheme
4. **Question:** Which application opens?
5. Clean up both registrations

**Expected result:** Calculator opens (HKCU wins!)

---

### 📊 Quick Reference Table

| Aspect | HKCU | HKLM |
|--------|------|------|
| Path | `HKCU\Software\Classes` | `HKLM\SOFTWARE\Classes` |
| Admin needed | No | Yes |
| Scope | Current user | All users |
| Precedence | Higher (wins) | Lower |
| Attack use | Common | Rare |
| Detection priority | HIGH | Medium |

---

### 📌 Key Takeaways

1. **HKCU requires no admin**—making it perfect for attackers
2. **HKCU takes precedence** over HKLM—enabling handler shadowing
3. **Monitor HKCU aggressively**—it's the primary attack vector
4. **HKCR is just a merged view**—check both hives separately
5. **Compare HKCU against HKLM baseline** to detect shadowing attacks

---

### ⚠️ SAFETY REMINDER

```
Always test in isolated environments!

✓ Use dedicated VMs for registry experiments
✓ Snapshot before making changes
✓ Clean up all test handlers
✓ Never modify registry on production systems

Educational purposes only.
```

---

### 🔜 Coming Next Week

In Part 5, we'll explore **invocation methods**—how attackers trigger protocol handlers through documents, browsers, and more. The attack surface is wider than you might think.

**Follow me** for Part 5!

---

### 💬 Discussion Question

Have you ever found a case of handler shadowing in your environment? How did you detect it?

---

#Cybersecurity #WindowsSecurity #Registry #BlueTeam #RedTeam #BYOPH #ThreatHunting #Persistence #InfoSec #SecurityResearch

