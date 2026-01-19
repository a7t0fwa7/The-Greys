# 📜 Licensing Guide

## The Greys - Cybersecurity Education Hub

This document provides comprehensive guidance on the licensing structure used in this repository.

---

## 🎯 Overview

This repository uses a **dual-license approach** to ensure that different types of content are licensed appropriately:

1. **Code & Software** → MIT License
2. **Educational Content** → Creative Commons Attribution 4.0 International (CC BY 4.0)

This approach is common in educational and open-source projects, providing maximum flexibility while ensuring proper attribution.

---

## 📋 License Breakdown

### 1. MIT License (Code & Software)

**Applies to:**
- All source code files (`.py`, `.ps1`, `.sh`, `.cpp`, `.c`, `.h`, `.js`, etc.)
- Scripts and automation tools
- Detection rules and queries (Sigma `.yml`, Sysmon `.xml`, PowerShell `.ps1`)
- Configuration files for technical tools
- Build scripts and CI/CD configurations
- Software utilities and helper tools

**Full License:** [LICENSE-CODE](LICENSE-CODE)

**Key Permissions:**
- ✅ Commercial use
- ✅ Modification
- ✅ Distribution
- ✅ Private use
- ✅ Sublicensing

**Requirements:**
- ⚠️ Include copyright notice
- ⚠️ Include license text

**Example Files:**
```
Articles/github-readme/BYOPH/samples/detection/hunting_queries.ps1
Articles/github-readme/BYOPH/samples/detection/byoph_detection.yml
Articles/github-readme/BYOPH/samples/detection/byoph_sysmon_config.xml
[Any .py, .ps1, .sh, .cpp files]
```

---

### 2. Creative Commons BY 4.0 (Educational Content)

**Applies to:**
- All markdown articles (`.md` files in `Articles/articles/`)
- Documentation and guides
- Diagrams and visual materials (Mermaid diagrams, images)
- Educational tutorials and explanations
- Presentation materials
- Infographics and illustrations
- Written commentary and analysis

**Full License:** [LICENSE-CONTENT](LICENSE-CONTENT)

**Key Permissions:**
- ✅ Share and redistribute
- ✅ Adapt and remix
- ✅ Commercial use
- ✅ Create derivatives

**Requirements:**
- ⚠️ Give appropriate credit (attribution)
- ⚠️ Provide link to license
- ⚠️ Indicate if changes were made
- ⚠️ No additional restrictions

**Example Files:**
```
Articles/articles/BYOPH/01-introduction.md
Articles/articles/BYOPH/02-attack-analysis.md
README.md
CONTRIBUTING.md
Articles/diagrams/BYOPH/*.md
```

---

## 🔍 How to Determine Which License Applies

### Quick Reference Table

| File Type | Extension | License | License File |
|-----------|-----------|---------|--------------|
| Python scripts | `.py` | MIT | LICENSE-CODE |
| PowerShell scripts | `.ps1` | MIT | LICENSE-CODE |
| Bash scripts | `.sh` | MIT | LICENSE-CODE |
| C/C++ code | `.c`, `.cpp`, `.h` | MIT | LICENSE-CODE |
| Sigma rules | `.yml` | MIT | LICENSE-CODE |
| Sysmon config | `.xml` | MIT | LICENSE-CODE |
| Articles | `.md` (in Articles/articles/) | CC BY 4.0 | LICENSE-CONTENT |
| Documentation | `.md` (root level) | CC BY 4.0 | LICENSE-CONTENT |
| Diagrams | `.md`, images | CC BY 4.0 | LICENSE-CONTENT |
| HTML pages | `.html` | CC BY 4.0 | LICENSE-CONTENT |

### Decision Tree

```
Is it executable code or a technical configuration?
├─ YES → MIT License (LICENSE-CODE)
└─ NO → Is it educational/creative content?
    ├─ YES → CC BY 4.0 (LICENSE-CONTENT)
    └─ UNSURE → Check file header or ask in issues
```

---

## 📝 How to Use Content from This Repository

### Using Code (MIT License)

**Example: Using a PowerShell hunting query**

1. Copy the code
2. Include this notice in your project:

```powershell
# Copyright (c) 2026 Mr.b3d0u55i (a7t0fwa7)
# Licensed under the MIT License
# Source: https://github.com/a7t0fwa7/The-Greys
```

3. Include a copy of the MIT License (from LICENSE-CODE) in your project

**That's it!** You can use it commercially, modify it, distribute it freely.

---

### Using Content (CC BY 4.0)

**Example: Using an article or diagram**

1. Copy or adapt the content
2. Provide attribution like this:

```markdown
"BYOPH Part 1: The Hidden Attack Surface" by Mr.b3d0u55i (a7t0fwa7)
From: The Greys - Cybersecurity Education Hub
URL: https://a7t0fwa7.github.io/The-Greys/
License: CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
```

3. If you modified the content, indicate what you changed:

```markdown
"BYOPH Part 1: The Hidden Attack Surface" by Mr.b3d0u55i (a7t0fwa7), adapted by [Your Name]
Changes: [Brief description of changes]
From: The Greys - Cybersecurity Education Hub
URL: https://a7t0fwa7.github.io/The-Greys/
License: CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/)
```

**That's it!** You can share, remix, and even use commercially with proper attribution.

---

## 🤝 Contributing to This Repository

When you contribute to this repository, you agree that:

1. **Code contributions** will be licensed under the MIT License
2. **Content contributions** will be licensed under CC BY 4.0
3. You have the legal right to license your contributions under these terms
4. You understand and accept these licensing terms

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details on how to contribute.

---

## ❓ Frequently Asked Questions

### Can I use this content in my commercial training course?

**Yes!** Both licenses allow commercial use.

- **Code (MIT):** Use freely, just include the copyright notice
- **Content (CC BY 4.0):** Use freely, just provide attribution

### Can I modify the code/content?

**Yes!** Both licenses allow modifications.

- **Code (MIT):** Modify freely, include original copyright notice
- **Content (CC BY 4.0):** Modify freely, indicate changes made, provide attribution

### Do I need to share my modifications?

**No.** Neither license requires you to share your modifications (they're not "copyleft" licenses).

However, we encourage you to contribute improvements back to the community!

### Can I relicense this content?

- **Code (MIT):** You can sublicense your modifications under different terms
- **Content (CC BY 4.0):** You cannot apply additional restrictions, but you can add your own content under different terms

### What if I only want to link to the content?

**No attribution required for simple links!** Just link to the page. Attribution is only required if you copy/redistribute the actual content.

### Can I use this in my company's internal documentation?

**Yes!** Both licenses allow this. For internal use, attribution can be minimal (e.g., a footnote with the source URL).

---

## 📚 Additional Resources

### License Texts
- **MIT License Full Text:** [LICENSE-CODE](LICENSE-CODE)
- **CC BY 4.0 Full Text:** [LICENSE-CONTENT](LICENSE-CONTENT)
- **Main License Overview:** [LICENSE](LICENSE)

### External Resources
- **MIT License Info:** https://opensource.org/licenses/MIT
- **CC BY 4.0 Info:** https://creativecommons.org/licenses/by/4.0/
- **CC BY 4.0 Legal Code:** https://creativecommons.org/licenses/by/4.0/legalcode
- **Choose a License Guide:** https://choosealicense.com/

---

## 📞 Questions?

If you have questions about licensing:

1. **Check this guide first** - Most questions are answered here
2. **Open an issue** - https://github.com/a7t0fwa7/The-Greys/issues

---

**Last Updated:** January 19, 2026  
**Repository:** https://github.com/a7t0fwa7/The-Greys  
**Website:** https://a7t0fwa7.github.io/The-Greys/

