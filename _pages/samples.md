---
layout: default
title: Code Samples
permalink: /samples/
---

# 🛠️ Code Samples & Lab Resources

Hands-on code samples for understanding and testing Windows protocol handler attacks in isolated lab environments.

---

## ⚠️ CRITICAL SAFETY WARNING

**ALL samples must be used ONLY in isolated lab environments!**

- ✅ Use dedicated VMs with snapshots
- ✅ Disconnect from production networks
- ✅ Test only on systems you own or have authorization to test
- ❌ NEVER test on production systems
- ❌ NEVER use for unauthorized access

---

## 📁 Sample Categories

### 🔧 Registration Files

Registry files for creating and removing protocol handlers.

#### HKCU (Current User - No Admin Required)

**Register Handler:**
```batch
# Download and import
regedit /s register_notepad_hkcu.reg
```
[Download register_notepad_hkcu.reg](../Articles/github-readme/BYOPH/samples/registration/register_notepad_hkcu.reg)

**Unregister Handler:**
```batch
# Cleanup
regedit /s unregister_sample_hkcu.reg
```
[Download unregister_sample_hkcu.reg](../Articles/github-readme/BYOPH/samples/registration/unregister_sample_hkcu.reg)

---

#### HKLM (All Users - Requires Admin)

**Register Handler:**
```batch
# Right-click and "Run as administrator"
regedit /s register_notepad_hklm.reg
```
[Download register_notepad_hklm.reg](../Articles/github-readme/BYOPH/samples/registration/register_notepad_hklm.reg)

**Unregister Handler:**
```batch
# Right-click and "Run as administrator"
regedit /s unregister_sample_hklm.reg
```
[Download unregister_sample_hklm.reg](../Articles/github-readme/BYOPH/samples/registration/unregister_sample_hklm.reg)

---

### 🧪 Invocation Tests

Test files for triggering registered protocol handlers.

#### HTML Test Page

Interactive test page with multiple invocation methods:
- Anchor tag (`<a href="sample://...">`)
- JavaScript (`window.location`)
- Meta refresh
- Form submission

[View test-handler.html](../Articles/github-readme/BYOPH/samples/invocation/test-handler.html)

**Usage:**
1. Register a handler (see above)
2. Open the HTML file in a browser
3. Click test links to invoke the handler
4. Observe behavior in Notepad or your custom handler

---

### 💻 Custom Handler Source Code

Build your own protocol handler for advanced testing.

**Coming Soon:** C++ logging handler source code

**Features:**
- Logs all invocations to a file
- Displays MessageBox with URL
- Safe for testing (no network activity)
- Demonstrates proper handler implementation

---

## 🎯 Quick Start Guide

### Step 1: Prepare Your Lab

```powershell
# Create a VM snapshot BEFORE making changes
# In Hyper-V, VMware, or VirtualBox:
# 1. Shut down the VM
# 2. Create a snapshot named "Pre-BYOPH-Testing"
# 3. Start the VM
```

### Step 2: Register a Test Handler

```batch
# Download the HKCU registration file
# Double-click to import (no admin needed)
regedit /s register_notepad_hkcu.reg
```

### Step 3: Test the Handler

```batch
# Method 1: Command line
start sample://hello-world

# Method 2: Browser
# Navigate to: sample://test-from-browser

# Method 3: HTML file
# Open test-handler.html and click links
```

### Step 4: Verify Registration

```powershell
# Check if handler is registered
Get-ItemProperty "HKCU:\Software\Classes\sample\shell\open\command"
```

### Step 5: Cleanup

```batch
# Remove the handler
regedit /s unregister_sample_hkcu.reg

# Verify removal
reg query "HKCU\Software\Classes\sample"
# Should return: ERROR: The system was unable to find the specified registry key or value.
```

---

## 📚 Related Resources

- **[Detection Rules](../detection/)** - Hunt for malicious handlers
- **[Articles](../articles/)** - Learn the theory behind the attacks
- **[Diagrams](../Articles/diagrams/BYOPH/all-diagrams.html)** - Visual attack flows

---

## 🔍 What to Observe

When testing handlers, pay attention to:

1. **Browser Prompts:** Some browsers warn before invoking unknown protocols
2. **Process Creation:** Use Process Monitor to see handler execution
3. **Command Line:** Check what arguments are passed to the handler
4. **Registry Changes:** Monitor registry with RegShot or Process Monitor
5. **Event Logs:** Check Windows Event Logs for handler invocations

---

## 💡 Lab Exercise Ideas

### Exercise 1: Basic Handler Testing
- Register HKCU handler
- Test from browser, HTML, and command line
- Observe differences in behavior

### Exercise 2: Precedence Testing
- Register both HKCU and HKLM handlers with different commands
- Test which one takes precedence
- Document your findings

### Exercise 3: Detection Testing
- Register a handler
- Run the PowerShell hunting queries
- Verify your handler is detected

### Exercise 4: Cleanup Verification
- Register a handler
- Unregister it
- Verify complete removal with multiple methods

---

## 🛡️ Safety Checklist

Before testing, ensure:

- [ ] Testing in an isolated VM
- [ ] VM snapshot created
- [ ] Disconnected from production network
- [ ] Using benign test handlers only
- [ ] Have cleanup scripts ready
- [ ] Documented what you're testing
- [ ] Know how to restore from snapshot

---

[← Back to Home](../) | [Articles →](../articles/) | [Detection Rules →](../detection/)

