# Article 3: Building a Safe Testing Ground

## Your BYOPH Lab Handler

**Series:** Decoding BYOPH (Part 3 of 7)
**Reading time:** 6 minutes
**Skill level:** Intermediate (hands-on)

---

## 📝 LinkedIn Post Content

You can't defend against what you don't understand. Today, I'll show you how to build a completely benign protocol handler so you can safely experiment with this technique in your lab.

No malware. No network callbacks. Just a simple tool that shows you exactly how protocol handlers work.

---

### 🎯 What You'll Learn Today

✅ Set up a proper isolated testing environment
✅ Build a safe demo handler that logs invocations
✅ Understand how Windows passes URLs to handlers
✅ Create your first working protocol handler

---

### 🔬 Why Build Your Own Handler?

Testing security concepts with real malware is:
• Dangerous (things can escape VMs)
• Unnecessary (you don't need malware to understand mechanics)
• Risky (could trigger legal issues)

A benign handler gives you:
• Full visibility into the mechanism
• Safe experimentation
• A tool for demonstrating to colleagues
• Evidence for reports and documentation

---

### 🖥️ Lab Environment Checklist

Before we start, verify your setup:

```
☐ Isolated Windows 10/11 VM (not your daily driver!)
☐ Snapshot created BEFORE any testing
☐ Network isolated or host-only
☐ Visual Studio Build Tools installed (optional)
☐ Text editor ready (Notepad++, VS Code)
☐ Cleanup scripts prepared
```

**Pro tip:** Take your snapshot with a clean registry state. The 5 minutes of verification can save hours of troubleshooting later.

---

### 🛠️ Option A: The Notepad Handler (No Coding Required)

The simplest handler uses Notepad—already on every Windows machine:

**Step 1: Create the .reg file**

```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\labtest]
@="URL:Lab Test Protocol"
"URL Protocol"=""

[HKEY_CURRENT_USER\Software\Classes\labtest\shell\open\command]
@="\"C:\\Windows\\System32\\notepad.exe\" \"%1\""
```

Save this as `register-labtest.reg`

**Step 2: Create the cleanup file**

```
Windows Registry Editor Version 5.00

[-HKEY_CURRENT_USER\Software\Classes\labtest]
```

Save as `unregister-labtest.reg`
(The `-` prefix means "delete this key")

**Step 3: Import and test**
1. Double-click `register-labtest.reg`
2. Click "Yes" on the UAC prompt
3. Open browser, navigate to `labtest://hello-world`
4. Accept the "Open external application?" prompt
5. Notepad opens with the URL as the filename

**What you'll see:** Notepad opens and displays "labtest://hello-world" in the title bar (or as an error since it's not a real file).

---

### 🛠️ Option B: Custom Handler (With Logging)

For more visibility, build a handler that logs everything:

**What it does:**
1. Captures the URL passed by Windows
2. Writes it to a log file in %TEMP%
3. Shows a MessageBox with the URL
4. Exits cleanly

**The code (C++):**

```cpp
#include <windows.h>
#include <shellapi.h>
#include <stdio.h>

int WINAPI wWinMain(HINSTANCE hInst, HINSTANCE hPrev, 
                    LPWSTR lpCmd, int nShow) {
    int argc;
    LPWSTR* argv = CommandLineToArgvW(GetCommandLineW(), &argc);
    
    WCHAR logPath[MAX_PATH];
    GetTempPathW(MAX_PATH, logPath);
    wcscat_s(logPath, L"byoph-handler.log");
    
    // Log the invocation
    FILE* f;
    _wfopen_s(&f, logPath, L"a");
    if (f) {
        fwprintf(f, L"Handler invoked with: %s\n", 
                 argc > 1 ? argv[1] : L"(no argument)");
        fclose(f);
    }
    
    // Show MessageBox
    MessageBoxW(NULL, 
                argc > 1 ? argv[1] : L"No URL provided",
                L"BYOPH Handler Demo", 
                MB_OK | MB_ICONINFORMATION);
    
    LocalFree(argv);
    return 0;
}
```

**Compile with:**
```batch
cl /EHsc ByophHandler.cpp /link user32.lib shell32.lib
```

---

### 📋 Understanding the Flow

```
User clicks: labtest://data/here

Windows:
├── Searches HKCU\Software\Classes\labtest
├── Finds shell\open\command
├── Reads: "C:\path\handler.exe" "%1"
├── Replaces %1 with full URL
└── Executes: "C:\path\handler.exe" "labtest://data/here"

Handler:
├── Receives URL as argv[1]
├── Logs to %TEMP%\byoph-handler.log
├── Shows MessageBox
└── Exits
```

---

### ✅ Verification Steps

After setting up your handler:

1. **Check registry:** Open regedit, navigate to `HKCU\Software\Classes\labtest`
2. **Test invocation:** Browser → `labtest://test123`
3. **Verify prompt:** Should see "Open external application?" dialog
4. **Confirm execution:** MessageBox appears with URL
5. **Check log:** `type %TEMP%\byoph-handler.log`

---

### 🧹 Cleanup Procedure

**Always clean up after testing:**

```batch
:: Method 1: Using .reg file
regedit /s unregister-labtest.reg

:: Method 2: Manual
reg delete "HKCU\Software\Classes\labtest" /f

:: Method 3: Revert VM snapshot (recommended)
```

---

### ⚠️ Common Pitfalls

| Problem | Cause | Solution |
|---------|-------|----------|
| Handler not invoked | Missing URL Protocol value | Add the empty string value |
| "App not found" error | Wrong path in command | Use full absolute path |
| Quotes breaking | Improper escaping | Use `\"` in .reg files |
| Still seeing old handler | Browser caching | Restart browser |

---

### 📌 Key Takeaways

1. **Always use isolated VMs** for security testing
2. **Notepad handlers** work great for quick demos
3. **Custom handlers** give you logging and control
4. The **%1 placeholder** is where Windows injects the URL
5. **Cleanup is essential**—use snapshots liberally

---

### ⚠️ SAFETY REMINDER

```
Lab Environment Only!

✓ Work in isolated virtual machines
✓ Take snapshots before making registry changes
✓ Have cleanup procedures ready
✓ Never test on production systems

This is educational content for authorized testing only.
```

---

### 🔜 Coming Next Week

In Part 4, we'll explore the difference between **HKCU and HKLM registration**—and why the precedence rules matter for both attackers and defenders.

**Follow me** for Part 4!

---

### 💬 Discussion Question

What's your preferred lab setup for security research? VirtualBox, VMware, Hyper-V, or something else? Share your tips!

---

#Cybersecurity #InfoSec #SecurityLab #BlueTeam #RedTeam #BYOPH #HandsOnLearning #WindowsSecurity #SecurityResearch #LabSetup

