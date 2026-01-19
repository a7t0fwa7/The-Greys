---
layout: default
title: BYOPH Series
permalink: /byoph/
---

# 🔐 BYOPH: Bring Your Own Protocol Handler

## Series 1 - Complete Educational Series

**Status:** ✅ Complete | **Level:** Intermediate | **Platform:** Windows | **Parts:** 7

---

## 📖 About This Series

**BYOPH (Bring Your Own Protocol Handler)** is an attack technique where adversaries register malicious Windows protocol handlers to achieve code execution, persistence, and evasion without exploits or admin privileges.

This comprehensive 7-part series takes you from basic concepts to advanced detection and evasion techniques.

---

## 🎯 What You'll Learn

- ✅ How Windows protocol handlers work (`mailto:`, `zoom://`, custom schemes)
- ✅ Attack techniques and persistence mechanisms
- ✅ Registry manipulation and precedence rules
- ✅ Multiple invocation methods (documents, browsers, emails)
- ✅ Detection and threat hunting strategies
- ✅ Incident response procedures
- ✅ Advanced OPSEC and evasion techniques

---

## 📚 Complete Series

### Part 1: The Hidden Attack Surface in Every Click
**Topics:** Protocol handlers, registry basics, attack chain overview

[Read Article 1 →](../Articles/articles/BYOPH/01-introduction.html)

**What You'll Learn:**
- How Windows protocol handlers work
- The attack chain from registration to execution
- Why this technique is so effective
- Real-world attack scenarios

---

### Part 2: Anatomy of an Attack
**Topics:** Artifact analysis, IoC extraction, forensic investigation

[Read Article 2 →](../Articles/articles/BYOPH/02-attack-analysis.html)

**What You'll Learn:**
- Dissecting malicious .reg files
- Identifying indicators of compromise
- Registry artifact analysis
- Attack reconstruction techniques

---

### Part 3: Building a Safe Testing Ground
**Topics:** Lab setup, benign handler creation, safe testing practices

[Read Article 3 →](../Articles/articles/BYOPH/03-lab-setup.html)

**What You'll Learn:**
- Setting up an isolated lab environment
- Creating benign test handlers
- Safe testing methodologies
- VM snapshot strategies

---

### Part 4: HKCU vs HKLM - Understanding Persistence
**Topics:** Registration methods, precedence rules, privilege requirements

[Read Article 4 →](../Articles/articles/BYOPH/04-registration.html)

**What You'll Learn:**
- HKCU vs HKLM registration differences
- Precedence rules and conflicts
- Privilege escalation considerations
- Persistence mechanisms

---

### Part 5: From Documents to Browsers
**Topics:** Invocation methods, attack surface analysis, delivery mechanisms

[Read Article 5 →](../Articles/articles/BYOPH/05-invocation.html)

**What You'll Learn:**
- Invoking handlers from Office documents
- Browser-based invocation techniques
- Email and chat application vectors
- Attack surface mapping

---

### Part 6: Hunting BYOPH - Detection and Response
**Topics:** Detection rules, Sysmon configuration, threat hunting

[Read Article 6 →](../Articles/articles/BYOPH/06-detection.html)

**What You'll Learn:**
- Sigma detection rules
- Sysmon configuration for handler monitoring
- PowerShell hunting queries
- Incident response procedures

---

### Part 7: OPSEC and the Future
**Topics:** Advanced techniques, evasion methods, evolved defenses

[Read Article 7 →](../Articles/articles/BYOPH/07-advanced-opsec.html)

**What You'll Learn:**
- Advanced OPSEC considerations
- Evasion techniques
- Custom handler development
- Future attack evolution

---

## 🛠️ Hands-On Resources

### Code Samples
- **[Registration Files](../Articles/github-readme/BYOPH/samples/registration/)** - HKCU and HKLM .reg files
- **[Invocation Tests](../Articles/github-readme/BYOPH/samples/invocation/)** - HTML and document test cases
- **[Custom Handlers](../Articles/github-readme/BYOPH/samples/)** - C++ logging handler source

### Detection Rules
- **[Sigma Rules](../Articles/github-readme/BYOPH/samples/detection/byoph_detection.yml)** - SIEM detection rules
- **[Sysmon Config](../Articles/github-readme/BYOPH/samples/detection/byoph_sysmon_config.xml)** - Enhanced logging
- **[Hunting Queries](../Articles/github-readme/BYOPH/samples/detection/hunting_queries.ps1)** - PowerShell scripts

### Visual Resources
- **[Attack Flow Diagrams](../Articles/diagrams/BYOPH/all-diagrams.html)** - Mermaid diagrams for all phases

---

## 🎓 Recommended Learning Path

### 🔵 Blue Team Path
1. Start with Parts 1-2 (Understanding the threat)
2. Jump to Part 6 (Detection and hunting)
3. Review Parts 3-5 for attack surface knowledge
4. Study Part 7 for advanced threats

### 🔴 Red Team Path
1. Read all parts sequentially (1-7)
2. Practice in isolated labs (Part 3)
3. Focus on OPSEC (Part 7)
4. Always obtain authorization

### 🔬 Research Path
1. Complete all parts for comprehensive understanding
2. Experiment with custom handlers
3. Develop new detection methods
4. Contribute findings back to the community

---

## ⚠️ Important Safety Notice

All content is for **educational and authorized security testing only**. Always:
- Test in isolated lab environments
- Obtain written authorization
- Follow responsible disclosure practices
- Never use for unauthorized access

---

[← Back to Home](../) | [All Series →](../articles/) | [Code Samples →](../samples/) | [Detection Rules →](../detection/)

