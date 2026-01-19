---
layout: default
title: All Series
permalink: /articles/
---

# 📚 All Educational Series

## Comprehensive Cybersecurity Education Across Multiple Domains

Explore our growing collection of in-depth educational series covering various cybersecurity topics. Each series provides complete coverage from basics to advanced techniques, with hands-on labs and detection strategies.

---

## 🔐 Series 1: BYOPH - Bring Your Own Protocol Handler

**Status:** ✅ Complete | **Level:** Intermediate | **Platform:** Windows | **Parts:** 7

A comprehensive guide to Windows protocol handler attacks, from basic concepts to advanced evasion techniques.

**[View Full Series →](../byoph/)**

### Quick Overview

Windows protocol handler attacks that achieve code execution, persistence, and evasion without exploits or admin privileges.

**Topics Covered:**
- Protocol handler mechanics and registry structure
- Attack techniques and persistence mechanisms
- Detection and threat hunting strategies
- Incident response procedures
- Advanced OPSEC and evasion techniques

**Resources:**
- 📚 7-part article series
- 🛠️ Working code samples and handlers
- 🔍 Detection rules (Sigma, Sysmon, PowerShell)
- 🧪 Lab exercises with cleanup scripts

---

### BYOPH Series Articles

#### Part 1: The Hidden Attack Surface in Every Click
**Topics:** Protocol handlers, registry basics, attack chain overview

[Read Article 1 →](../Articles/articles/BYOPH/01-introduction.html)

**What You'll Learn:**
- How Windows protocol handlers work
- The attack chain from registration to execution
- Why this technique is so effective
- Real-world attack scenarios

---

#### Part 2: Anatomy of an Attack
**Topics:** Artifact analysis, IoC extraction, forensic investigation

[Read Article 2 →](../Articles/articles/BYOPH/02-attack-analysis.html)

**What You'll Learn:**
- Dissecting malicious .reg files
- Identifying indicators of compromise
- Registry artifact analysis
- Attack reconstruction techniques

---

#### Part 3: Building a Safe Testing Ground
**Topics:** Lab setup, benign handler creation, safe testing practices

[Read Article 3 →](../Articles/articles/BYOPH/03-lab-setup.html)

---

#### Part 4: HKCU vs HKLM - Understanding Persistence
**Topics:** Registration methods, precedence rules, privilege requirements

[Read Article 4 →](../Articles/articles/BYOPH/04-registration.html)

---

#### Part 5: From Documents to Browsers
**Topics:** Invocation methods, attack surface analysis, delivery mechanisms

[Read Article 5 →](../Articles/articles/BYOPH/05-invocation.html)

---

#### Part 6: Hunting BYOPH - Detection and Response
**Topics:** Detection rules, Sysmon configuration, threat hunting

[Read Article 6 →](../Articles/articles/BYOPH/06-detection.html)

---

#### Part 7: OPSEC and the Future
**Topics:** Advanced techniques, evasion methods, evolved defenses

[Read Article 7 →](../Articles/articles/BYOPH/07-advanced-opsec.html)

**What You'll Learn:**
- Advanced OPSEC considerations
- Evasion techniques
- Custom handler development
- Future attack evolution

---

## 🚧 Coming Soon: Future Series

### 📧 Series 2: Advanced Phishing Techniques
**Status:** 🔜 Planned | **Level:** Intermediate | **Platform:** Cross-Platform

Email security analysis, link obfuscation, credential harvesting detection, and anti-phishing strategies.

---

### ⚡ Series 3: PowerShell Security
**Status:** 🔜 Planned | **Level:** Intermediate | **Platform:** Windows

Script analysis, deobfuscation, logging, offensive PowerShell techniques, and detection strategies.

---

### 🦠 Series 4: Malware Analysis Fundamentals
**Status:** 🔜 Planned | **Level:** Advanced | **Platform:** Cross-Platform

Static/dynamic analysis, reverse engineering basics, sandbox evasion, and behavioral analysis.

---

### 🔍 Series 5: Threat Hunting Methodologies
**Status:** 🔜 Planned | **Level:** Advanced | **Platform:** Cross-Platform

Hypothesis-driven hunting, data source analysis, tool development, and hunt documentation.

---

**💡 Want to see a specific topic?** [Suggest a series →](https://github.com/a7t0fwa7/The-Greys/issues)

---

## ⚠️ Important Notice

All content is for **educational and authorized security testing only**. Always:
- Test in isolated lab environments
- Obtain written authorization
- Follow responsible disclosure practices
- Never use for unauthorized access

---

[← Back to Home](../) | [BYOPH Series →](../byoph/) | [Code Samples →](../samples/) | [Detection Rules →](../detection/)

