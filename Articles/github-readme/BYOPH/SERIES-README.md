# 🔐 BYOPH: Bring Your Own Protocol Handler

## A Security Professional's Guide to Windows Protocol Handler Attacks

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows%2010%2F11-blue.svg)](https://www.microsoft.com/windows)
[![Purpose: Educational](https://img.shields.io/badge/Purpose-Educational-green.svg)](#disclaimer)

---

## 📖 Overview

This repository accompanies the **7-part LinkedIn article series** on Windows URL Protocol Handler attacks (BYOPH). It includes:

- 📚 Complete article content
- 🛠️ Working code samples
- 📊 Detection rules (Sigma, Sysmon)
- 🧪 Lab exercises with cleanup scripts

**The technique:** Attackers register custom URL protocol handlers that execute arbitrary code when a user clicks a specially crafted link.

---

## ⚠️ Disclaimer

```
╔══════════════════════════════════════════════════════════════════════════════╗
║                              EDUCATIONAL USE ONLY                            ║
╠══════════════════════════════════════════════════════════════════════════════╣
║  This content is for authorized security testing and educational purposes.  ║
║                                                                              ║
║  ✓ Always use isolated lab environments                                     ║
║  ✓ Never test on systems without explicit written authorization             ║
║  ✓ Follow your organization's rules of engagement                           ║
║  ✓ Respect applicable laws (CFAA, Computer Misuse Act, etc.)               ║
║                                                                              ║
║  Unauthorized access to computer systems is a criminal offense.              ║
║  The author is not responsible for misuse of this information.              ║
╚══════════════════════════════════════════════════════════════════════════════╝
```

---

## 📚 Article Series

| Part | Title | Topics Covered |
|------|-------|----------------|
| 1 | [The Hidden Attack Surface in Every Click](articles/01-introduction.md) | Protocol handlers, registry basics, attack chain |
| 2 | [Anatomy of an Attack](articles/02-attack-analysis.md) | Artifact analysis, IoC extraction |
| 3 | [Building a Safe Testing Ground](articles/03-lab-setup.md) | Lab setup, benign handler creation |
| 4 | [HKCU vs HKLM](articles/04-registration.md) | Registration methods, precedence rules |
| 5 | [From Documents to Browsers](articles/05-invocation.md) | Invocation methods, attack surface |
| 6 | [Hunting BYOPH](articles/06-detection.md) | Detection rules, Sysmon, Sigma |
| 7 | [OPSEC and the Future](articles/07-advanced-opsec.md) | Advanced techniques, evolved defenses |

---

## 🛠️ Quick Start

### Prerequisites

- Windows 10/11 VM (isolated!)
- Visual Studio Build Tools (optional, for custom handler)
- Text editor (Notepad++, VS Code)

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/byoph-series.git
cd byoph-series
```

### 2. Create a VM Snapshot

**CRITICAL:** Before making any registry changes, snapshot your VM!

### 3. Register a Test Handler

```batch
# Import the Notepad handler (per-user, no admin)
regedit /s samples\register_notepad_hkcu.reg

# Test it
start sample://hello-world

# Cleanup
regedit /s samples\unregister_sample_hkcu.reg
```

---

## 📁 Repository Structure

```
byoph-series/
├── README.md                 # This file
├── articles/                 # Full LinkedIn article content
│   ├── 01-introduction.md
│   ├── 02-attack-analysis.md
│   └── ...
├── samples/                  # Working code samples
│   ├── handlers/
│   │   ├── notepad-handler/
│   │   └── logging-handler/
│   ├── registration/
│   │   ├── register_notepad_hkcu.reg
│   │   ├── register_notepad_hklm.reg
│   │   └── unregister_*.reg
│   └── invocation/
│       ├── test-link.html
│       └── test-document.docx
├── detection/                # Blue team resources
│   ├── sigma/
│   │   └── byoph_detection.yml
│   ├── sysmon/
│   │   └── byoph_sysmon_config.xml
│   └── hunting/
│       └── hunting_queries.ps1
└── diagrams/                 # Mermaid diagrams
    └── all-diagrams.md
```

---

## 🧪 Code Samples

### Sample 1: Notepad Handler (.reg)

```reg
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\sample]
@="URL:Sample Protocol"
"URL Protocol"=""

[HKEY_CURRENT_USER\Software\Classes\sample\shell\open\command]
@="\"C:\\Windows\\System32\\notepad.exe\" \"%1\""
```

### Sample 2: Logging Handler (C++)

```cpp
#include <windows.h>
#include <shellapi.h>
#include <stdio.h>

int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hPrev, 
                    LPWSTR lpCmd, int nShow) {
    int argc;
    LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);
    
    // Log to temp file
    WCHAR logPath[MAX_PATH];
    GetTempPathW(MAX_PATH, logPath);
    wcscat_s(logPath, L"byoph-handler.log");
    
    FILE* f;
    _wfopen_s(&f, logPath, L"a");
    if (f) {
        fwprintf(f, L"[%s] Invoked with: %s\n", 
                 L"TIMESTAMP", argc > 1 ? argv[1] : L"(none)");
        fclose(f);
    }
    
    // Visual confirmation
    MessageBoxW(NULL, 
                argc > 1 ? argv[1] : L"No URL provided",
                L"BYOPH Handler", MB_OK);
    
    LocalFree(argv);
    return 0;
}
```

### Sample 3: HTML Test Page

```html
<!DOCTYPE html>
<html>
<head><title>BYOPH Test</title></head>
<body>
    <h1>Protocol Handler Test</h1>
    <p><a href="sample://test-from-anchor">Test: Anchor Tag</a></p>
    <button onclick="window.location='sample://test-from-js'">
        Test: JavaScript
    </button>
</body>
</html>
```

---

## 🔍 Detection Resources

### Sigma Rule

```yaml
title: Suspicious Protocol Handler Registration
status: experimental
logsource:
    product: windows
    category: registry_set
detection:
    selection:
        TargetObject|contains: '\Software\Classes\'
        TargetObject|endswith: '\shell\open\command'
    filter:
        Details|contains:
            - 'powershell'
            - 'cmd.exe'
            - 'http://'
    condition: selection and filter
level: high
```

### PowerShell Hunting Query

```powershell
# Find all protocol handlers for current user
Get-ChildItem "HKCU:\Software\Classes" | 
Where-Object { 
    (Get-ItemProperty $_.PSPath -Name "URL Protocol" -ErrorAction SilentlyContinue)
} | ForEach-Object {
    $cmd = Get-ItemProperty "$($_.PSPath)\shell\open\command" -EA SilentlyContinue
    [PSCustomObject]@{
        Scheme = $_.PSChildName
        Command = $cmd.'(Default)'
    }
}
```

---

## 🧹 Cleanup Commands

```batch
:: Per-user cleanup
reg delete "HKCU\Software\Classes\sample" /f

:: System-wide cleanup (run as admin)
reg delete "HKLM\SOFTWARE\Classes\sample" /f

:: Or use the provided .reg files
regedit /s samples\registration\unregister_sample_hkcu.reg
```

---

## 📊 Key Concepts Summary

| Concept | Key Point |
|---------|-----------|
| Protocol Handler | Registry entry mapping URL scheme to application |
| HKCU | Per-user, no admin required, higher precedence |
| HKLM | System-wide, admin required, lower precedence |
| URL Protocol | Empty string value marking key as URL handler |
| %1 | Placeholder replaced with full URL |

---

## 🤝 Contributing

Contributions welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

All contributions must be for **educational/defensive purposes only**.

---

## 📜 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.

---

## 🔗 Resources

- [Microsoft: Registering an Application to a URI Scheme](https://docs.microsoft.com/en-us/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa767914(v=vs.85))
- [MITRE ATT&CK: T1218 - System Binary Proxy Execution](https://attack.mitre.org/techniques/T1218/)
- [Sigma Rules Repository](https://github.com/SigmaHQ/sigma)

---

## 📧 Contact

- LinkedIn: [Your Profile]
- Twitter: [@YourHandle]
- Blog: [Your Blog URL]

---

**Stay safe. Test responsibly. Defend effectively.**

