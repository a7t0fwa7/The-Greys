---
layout: default
title: Home
---

# 🎓 The Greys: Cybersecurity Education Hub

## Building a Safer Digital World Through Education and Collaboration

Welcome to **The Greys** - a comprehensive cybersecurity education platform featuring in-depth research, hands-on labs, and detection strategies across multiple security domains.

---

## 🌟 What is The Greys?

**The Greys** is a growing collection of educational content designed for security professionals, researchers, and enthusiasts. Each series provides:

- 📚 **Complete attack lifecycle coverage** - From basics to advanced techniques
- 🛠️ **Working code samples** - Hands-on learning with real examples
- 🔍 **Detection rules** - Sigma, Sysmon, PowerShell, and EDR rules
- 🧪 **Safe lab environments** - Isolated testing with cleanup scripts
- 🎯 **Real-world scenarios** - Practical applications and case studies
- 🛡️ **Defensive strategies** - Blue team focused detection and response

---

## 📚 Educational Series

### 🔐 Series 1: BYOPH - Bring Your Own Protocol Handler

**Status:** ✅ Complete | **Level:** Intermediate | **Platform:** Windows | **Parts:** 7

Deep-dive into Windows protocol handler attacks, from basic concepts to advanced evasion techniques.

**Topics Covered:**
- Protocol handler mechanics and registry structure
- Attack techniques and persistence mechanisms
- Detection and threat hunting strategies
- Incident response procedures
- Advanced OPSEC and evasion techniques

**Resources:**
- 📚 [Complete 7-part series](Articles/articles/BYOPH/01-introduction.html)
- 🛠️ [Code samples & handlers](Articles/github-readme/BYOPH/samples/)
- 🔍 [Detection rules (Sigma, Sysmon, PowerShell)](Articles/github-readme/BYOPH/samples/detection/)

**[Start Learning →](Articles/articles/BYOPH/01-introduction.html)** | **[View All Articles →](articles/)**

---

### 🚧 Coming Soon: Future Series

#### 📧 Series 2: Advanced Phishing Techniques
**Status:** 🔜 Planned | **Level:** Intermediate | **Platform:** Cross-Platform

Email security analysis, link obfuscation, credential harvesting detection, and anti-phishing strategies.

---

#### ⚡ Series 3: PowerShell Security
**Status:** 🔜 Planned | **Level:** Intermediate | **Platform:** Windows

Script analysis, deobfuscation, logging, offensive PowerShell techniques, and detection strategies.

---

#### 🦠 Series 4: Malware Analysis Fundamentals
**Status:** 🔜 Planned | **Level:** Advanced | **Platform:** Cross-Platform

Static/dynamic analysis, reverse engineering basics, sandbox evasion, and behavioral analysis.

---

#### 🔍 Series 5: Threat Hunting Methodologies
**Status:** 🔜 Planned | **Level:** Advanced | **Platform:** Cross-Platform

Hypothesis-driven hunting, data source analysis, tool development, and hunt documentation.

---

**💡 Want to see a specific topic?** [Suggest a series →](https://github.com/a7t0fwa7/The-Greys/issues)

---

## 🚀 Getting Started

### Choose Your Path

**🔵 Blue Team / Defenders**
1. Start with [Detection Rules](detection/) to understand what to monitor
2. Read attack technique articles to understand threats
3. Deploy Sigma rules and Sysmon configurations
4. Practice threat hunting in your environment

**🔴 Red Team / Pentesters**
1. Complete full article series to understand techniques
2. Set up isolated lab environments for safe testing
3. Study OPSEC and evasion strategies
4. Always obtain proper authorization

**🔬 Security Researchers**
1. Deep dive into complete attack chains
2. Experiment with custom tools and techniques
3. Develop new detection methods
4. Share findings responsibly with the community

**🎯 SOC Analysts**
1. Focus on detection rules and alert tuning
2. Learn attack patterns and indicators
3. Practice incident investigation scenarios
4. Build response playbooks

---

## 🛠️ Quick Start: Try the BYOPH Series

### Prerequisites

- Windows 10/11 VM (isolated!)
- Visual Studio Build Tools (optional)
- Text editor (Notepad++, VS Code)

### Test a Protocol Handler

```bash
# 1. Clone the repository
git clone https://github.com/a7t0fwa7/The-Greys.git
cd The-Greys

# 2. Create VM snapshot (CRITICAL!)

# 3. Register test handler (no admin needed)
regedit /s Articles/github-readme/BYOPH/samples/registration/register_notepad_hkcu.reg

# 4. Test it
start sample://hello-world

# 5. Cleanup
regedit /s Articles/github-readme/BYOPH/samples/registration/unregister_sample_hkcu.reg
```

---

## 📁 Resources by Category

### 🔬 Code Samples & Labs

Hands-on learning materials for safe experimentation:

- **[BYOPH Samples](Articles/github-readme/BYOPH/samples/)** - Protocol handler registration, invocation tests
- **[Detection Scripts](Articles/github-readme/BYOPH/samples/detection/)** - PowerShell hunting queries
- **[Lab Exercises](samples/)** - Step-by-step guided exercises

**[Browse All Samples →](samples/)**

### 🔍 Detection & Hunting

Blue team resources for threat detection:

- **[Sigma Rules](detection/)** - SIEM-agnostic detection rules
- **[Sysmon Configs](Articles/github-readme/BYOPH/samples/detection/)** - Enhanced logging configurations
- **[Hunting Queries](Articles/github-readme/BYOPH/samples/detection/hunting_queries.ps1)** - PowerShell threat hunting
- **[EDR Rules](detection/)** - Endpoint detection and response

**[Browse All Detection Rules →](detection/)**

### 📊 Visual Resources

Attack flows, diagrams, and visual learning aids:

- **[Attack Flow Diagrams](Articles/diagrams/BYOPH/all-diagrams.html)** - Mermaid diagrams
- **[Architecture Diagrams](Articles/diagrams/)** - System and network diagrams
- **[Process Flows](Articles/diagrams/)** - Step-by-step visual guides

### 📚 Documentation

Guides and references:

- **[Setup Guide](GITHUB_PAGES_SETUP.md)** - How to deploy your own instance
- **[Content Guide](ADDING_CONTENT_GUIDE.md)** - How to add new content
- **[Contributing](CONTRIBUTING.md)** - How to contribute to the project

---

## 🎯 Featured Content

### 🔥 Most Popular

- **[BYOPH Part 1: The Hidden Attack Surface](Articles/articles/BYOPH/01-introduction.html)** - Start here!
- **[Detection Rules Collection](detection/)** - Ready-to-deploy Sigma rules
- **[PowerShell Hunting Queries](Articles/github-readme/BYOPH/samples/detection/hunting_queries.ps1)** - Find threats now

### 🆕 Recently Added

- ✅ BYOPH Series Complete (7 parts)
- ✅ Sigma Detection Rules
- ✅ Sysmon Configuration
- ✅ PowerShell Hunting Queries

### 📅 Coming Next

- 🔜 Advanced Phishing Techniques Series
- 🔜 PowerShell Security Series
- 🔜 Malware Analysis Fundamentals
- 🔜 Threat Hunting Methodologies

---

## 🤝 Community & Contributions

**Join the Community:**
- ⭐ **Star this repository** to show support
- 👁️ **Watch** for new content releases
- 🔔 **Follow** [@a7t0fwa7](https://github.com/a7t0fwa7) for updates
- 💬 **Discuss** in [GitHub Discussions](https://github.com/a7t0fwa7/The-Greys/discussions)

**Contribute:**
- 📝 Write new articles or tutorials
- 🔍 Share detection rules and hunting queries
- 🛠️ Add code samples and tools
- 🐛 Report issues or suggest improvements

**[Read Contributing Guidelines →](CONTRIBUTING.md)**

---

## ⚠️ Safety & Ethics

**This platform is STRICTLY for educational and defensive purposes:**

### ✅ Acceptable Use
- Educational learning and research
- Authorized security testing with written permission
- Defensive security improvements
- Academic research and publication

### ❌ Prohibited Use
- Unauthorized access to systems or networks
- Malicious attacks or exploitation
- Testing without explicit authorization
- Illegal activities of any kind

**Always:**
- 🔒 Test only in **isolated lab environments**
- 📝 Obtain **written authorization** before testing production systems
- 🛡️ Follow **responsible disclosure** practices
- ⚖️ Comply with all applicable laws and regulations

**The author assumes no liability for misuse of this information.**

---

## 📊 Platform Statistics

- **📚 Series Published:** 1 (BYOPH - Complete)
- **🚧 Series Planned:** 4+ (Phishing, PowerShell, Malware, Threat Hunting)
- **📝 Total Articles:** 7+ (Growing)
- **🔍 Detection Rules:** Sigma, Sysmon, PowerShell, EDR
- **🛠️ Code Samples:** Handlers, Scripts, Tools, Labs
- **🧪 Lab Exercises:** Multiple hands-on scenarios

---

## 📜 License

This project is licensed under the terms specified in the [LICENSE](LICENSE) file.

All content is provided for educational purposes only.

---

## 📞 Contact & Support

### Get in Touch
- **GitHub:** [@a7t0fwa7](https://github.com/a7t0fwa7)
- **Issues:** [Report bugs or request features](https://github.com/a7t0fwa7/The-Greys/issues)
- **Discussions:** [Join the conversation](https://github.com/a7t0fwa7/The-Greys/discussions)

### Stay Connected
- ⭐ Star this repository
- 👁️ Watch for updates
- 🔔 Follow for new releases
- 💬 Join discussions

---

## 🔖 Topics & Tags

`#Cybersecurity` `#InfoSec` `#BlueTeam` `#RedTeam` `#WindowsSecurity` `#ThreatHunting` `#BYOPH` `#SecurityResearch` `#PenTesting` `#IncidentResponse` `#Malware` `#Forensics` `#Detection` `#SIEM` `#EDR` `#SOC` `#Education`

---

<div style="text-align: center; margin-top: 40px; padding: 20px; background: #f0f0f0; border-radius: 5px;">
  <h3 style="margin-top: 0;">⚡ Educational Use Only</h3>
  <p>Always test in isolated environments. Obtain authorization before security testing.</p>
  <p><strong>Building a safer digital world through education and collaboration.</strong></p>
</div>

