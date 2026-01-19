# 🎓 The Greys: Cybersecurity Education Hub

[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-Live-success)](https://a7t0fwa7.github.io/The-Greys/)
[![License: MIT](https://img.shields.io/badge/Code-MIT-green.svg)](LICENSE-CODE)
[![License: CC BY 4.0](https://img.shields.io/badge/Content-CC%20BY%204.0-lightgrey.svg)](LICENSE-CONTENT)
[![Educational](https://img.shields.io/badge/Purpose-Educational-orange.svg)]()
[![Series](https://img.shields.io/badge/Series-Multiple-blue.svg)]()

> **A comprehensive cybersecurity education platform featuring in-depth research, hands-on labs, and detection strategies across multiple security domains**

---

## 🌐 Live Website

**Visit the full educational site:** [https://a7t0fwa7.github.io/The-Greys/](https://a7t0fwa7.github.io/The-Greys/)

---

## 📖 About The Greys

**The Greys** is a growing collection of cybersecurity educational content designed for security professionals, researchers, and enthusiasts. Each series provides:

- 📚 **In-depth article series** covering complete attack lifecycles
- 🛠️ **Working code samples** for hands-on learning
- 🔍 **Detection rules** (Sigma, Sysmon, PowerShell, EDR)
- 🧪 **Lab exercises** with safe testing environments
- 🎯 **Real-world scenarios** and case studies
- 🛡️ **Defensive strategies** for blue teams

---

## 🎯 What You'll Learn

This platform covers multiple cybersecurity domains:

- ✅ **Attack Techniques** - Understanding how attacks work
- ✅ **Detection & Hunting** - Finding threats in your environment
- ✅ **Incident Response** - Responding to security incidents
- ✅ **OPSEC & Evasion** - Advanced adversary techniques
- ✅ **Tool Development** - Building security tools
- ✅ **Forensics & Analysis** - Investigating security events

---

## 📚 Educational Series

### 🔐 Series 1: BYOPH - Bring Your Own Protocol Handler
**Status:** ✅ Complete (7 parts) | **Level:** Intermediate | **Platform:** Windows

A comprehensive deep-dive into Windows protocol handler attacks, from basic concepts to advanced evasion techniques.

**What You'll Learn:**
- How Windows protocol handlers work (`mailto:`, `zoom://`, custom schemes)
- Attack techniques and persistence mechanisms
- Detection and threat hunting strategies
- Incident response procedures
- Advanced OPSEC and evasion techniques

**Resources:**
- 📚 [7-part article series](https://a7t0fwa7.github.io/The-Greys/articles/)
- 🛠️ [Code samples & handlers](Articles/github-readme/BYOPH/samples/)
- 🔍 [Detection rules (Sigma, Sysmon, PowerShell)](Articles/github-readme/BYOPH/samples/detection/)
- 🧪 [Lab exercises with cleanup scripts](Articles/github-readme/BYOPH/samples/registration/)

**[Start Learning →](https://a7t0fwa7.github.io/The-Greys/Articles/articles/BYOPH/01-introduction.html)**

---

### 🚧 Coming Soon: Future Series

**Series 2: Advanced Phishing Techniques** *(Planned)*
- Email security and analysis
- Link obfuscation techniques
- Credential harvesting detection
- Anti-phishing strategies

**Series 3: PowerShell Security** *(Planned)*
- Script analysis and deobfuscation
- PowerShell logging and monitoring
- Offensive PowerShell techniques
- Detection and response

**Series 4: Malware Analysis Fundamentals** *(Planned)*
- Static and dynamic analysis
- Reverse engineering basics
- Sandbox evasion techniques
- Behavioral analysis

**Series 5: Threat Hunting Methodologies** *(Planned)*
- Hypothesis-driven hunting
- Data source analysis
- Tool development
- Hunt documentation

*Want to see a specific topic? [Open an issue](https://github.com/a7t0fwa7/The-Greys/issues) with your suggestion!*

---

## 🚀 Quick Start

### Explore the Website
Visit [The Greys Education Hub](https://a7t0fwa7.github.io/The-Greys/) to browse all content with an easy-to-navigate interface.

### Try the BYOPH Series

**Prerequisites:**
- Windows 10/11 VM (isolated!)
- Visual Studio Build Tools (optional)
- Text editor

**Quick Test:**
```batch
# 1. Create VM snapshot first!

# 2. Register test handler (no admin needed)
regedit /s Articles/github-readme/BYOPH/samples/registration/register_notepad_hkcu.reg

# 3. Test it
start sample://hello-world

# 4. Cleanup
regedit /s Articles/github-readme/BYOPH/samples/registration/unregister_sample_hkcu.reg
```

---

## 📁 Repository Structure

```
The-Greys/
├── Articles/
│   ├── articles/
│   │   ├── BYOPH/              # Series 1: Protocol handlers
│   │   ├── Phishing/           # Series 2: (Coming soon)
│   │   └── PowerShell/         # Series 3: (Coming soon)
│   ├── diagrams/               # Visual attack flows
│   └── github-readme/
│       └── BYOPH/samples/      # Code samples & detection
├── _config.yml                 # Jekyll configuration
├── _layouts/                   # Custom layouts
├── _pages/                     # Site pages
│   ├── articles.md             # All series index
│   ├── samples.md              # Code samples
│   └── detection.md            # Detection rules
├── index.md                    # Homepage
├── GITHUB_PAGES_SETUP.md       # Setup instructions
└── ADDING_CONTENT_GUIDE.md     # Content creation guide
```

---

## 🎓 Learning Paths

### 🔵 Blue Team / Defenders
1. **Start with detection** - Review detection rules and hunting queries
2. **Understand the threats** - Read attack technique articles
3. **Deploy monitoring** - Implement Sigma rules and Sysmon configs
4. **Practice hunting** - Run queries in your environment
5. **Establish baselines** - Document normal behavior

**Recommended Series:** BYOPH (detection focus), Threat Hunting (coming soon)

### 🔴 Red Team / Pentesters
1. **Learn the techniques** - Complete full article series
2. **Practice in labs** - Set up isolated environments
3. **Understand OPSEC** - Study evasion and detection avoidance
4. **Get authorization** - Always obtain proper permissions
5. **Document findings** - Help improve defensive posture

**Recommended Series:** BYOPH (complete series), Advanced OPSEC (coming soon)

### 🔬 Security Researchers
1. **Deep dive into topics** - Study complete attack chains
2. **Experiment safely** - Build custom tools and techniques
3. **Develop detections** - Create new detection methods
4. **Share responsibly** - Contribute findings to the community
5. **Collaborate** - Work with others on research

**Recommended Series:** All series, contribute new research

### 🎯 SOC Analysts
1. **Focus on detection** - Master detection rules and alerts
2. **Learn attack patterns** - Understand adversary techniques
3. **Practice investigation** - Work through incident scenarios
4. **Build playbooks** - Create response procedures
5. **Continuous learning** - Stay updated on new techniques

**Recommended Series:** BYOPH (detection), Incident Response (coming soon)

---

## 🤝 Contributing

We welcome contributions from the security community!

**Ways to Contribute:**
- 📝 **Submit new content** - Write articles or create tutorials
- 🔍 **Share detection rules** - Contribute Sigma rules, Sysmon configs
- 🛠️ **Add code samples** - Provide working examples and tools
- 🐛 **Report issues** - Found a bug or error? Let us know
- 💡 **Suggest topics** - Request new series or content
- 📚 **Improve documentation** - Fix typos, clarify explanations

**[Read Contributing Guidelines →](CONTRIBUTING.md)**

---

## ⚠️ Safety & Ethics

**This project is STRICTLY for educational and defensive purposes:**

### ✅ Acceptable Use
- Educational learning and research
- Authorized security testing with written permission
- Defensive security improvements
- Academic research and publication
- Security tool development for defense

### ❌ Prohibited Use
- Unauthorized access to systems or networks
- Malicious attacks or exploitation
- Testing without explicit authorization
- Illegal activities of any kind
- Harm to individuals or organizations

**The author assumes no liability for misuse of this information. Always:**
- 🔒 Test only in **isolated lab environments**
- 📝 Obtain **written authorization** before testing production systems
- 🛡️ Follow **responsible disclosure** practices
- ⚖️ Comply with all applicable laws and regulations

---

## 📜 License

This repository uses a **dual-license approach**:

### Code & Software → MIT License
All code, scripts, detection rules, and technical implementations are licensed under the **MIT License**.

**See:** [LICENSE-CODE](LICENSE-CODE)

### Educational Content → Creative Commons BY 4.0
All articles, documentation, diagrams, and educational materials are licensed under **Creative Commons Attribution 4.0 International (CC BY 4.0)**.

**See:** [LICENSE-CONTENT](LICENSE-CONTENT)

### Quick Summary

| What | License | Can I use commercially? | Attribution required? |
|------|---------|------------------------|----------------------|
| Code, Scripts, Detection Rules | MIT | ✅ Yes | ⚠️ Include copyright notice |
| Articles, Docs, Diagrams | CC BY 4.0 | ✅ Yes | ⚠️ Give credit to author |

**For detailed guidance:** See [LICENSING.md](LICENSING.md)

**Questions?** Open an issue on GitHub

---

**⚠️ Educational Use Disclaimer:** All content is provided for educational and authorized security testing purposes only. The author assumes no liability for misuse.

---

## 📞 Contact & Community

### Get in Touch
- **GitHub:** [@a7t0fwa7](https://github.com/a7t0fwa7)
- **Issues:** [Report bugs or request features](https://github.com/a7t0fwa7/The-Greys/issues)
- **Discussions:** [Join the conversation](https://github.com/a7t0fwa7/The-Greys/discussions)

### Stay Updated
- ⭐ **Star this repository** to get notifications
- 👁️ **Watch** for new content releases
- 🔔 **Follow** for updates on new series

---

## 🔖 Topics Covered

`#Cybersecurity` `#InfoSec` `#BlueTeam` `#RedTeam` `#WindowsSecurity` `#ThreatHunting` `#BYOPH` `#SecurityResearch` `#PenTesting` `#IncidentResponse` `#Malware` `#Forensics` `#Detection` `#SIEM` `#EDR` `#SOC`

---

## 📊 Repository Stats

- **Series Published:** 1 (BYOPH - Complete)
- **Series Planned:** 4+ (Phishing, PowerShell, Malware Analysis, Threat Hunting)
- **Total Articles:** 7+ (Growing)
- **Detection Rules:** Sigma, Sysmon, PowerShell, EDR
- **Code Samples:** Handlers, Scripts, Tools
- **Lab Exercises:** Multiple hands-on scenarios

---

<div align="center">
  <h3>⚡ Educational Use Only</h3>
  <p>Always test in isolated environments. Obtain authorization before security testing.</p>
  <p><strong>Building a safer digital world through education and collaboration.</strong></p>

  <br>

  [![GitHub Pages](https://img.shields.io/badge/Visit-Education%20Hub-success?style=for-the-badge)](https://a7t0fwa7.github.io/The-Greys/)

</div>

