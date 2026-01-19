# Contributing to BYOPH

Thank you for your interest in contributing to the BYOPH educational project! This guide will help you contribute effectively.

---

## 🎯 Ways to Contribute

### 1. Report Issues
- Found a bug in code samples?
- Discovered an error in articles?
- Have suggestions for improvements?

**[Open an Issue →](https://github.com/a7t0fwa7/The-Greys/issues)**

### 2. Improve Documentation
- Fix typos or unclear explanations
- Add examples or clarifications
- Improve code comments

### 3. Share Detection Rules
- Submit new Sigma rules
- Enhance Sysmon configurations
- Add hunting queries

### 4. Add Code Samples
- Create new handler examples
- Add invocation test cases
- Improve existing samples

### 5. Enhance the Website
- Improve styling and layout
- Fix broken links
- Add new features

---

## 📋 Contribution Guidelines

### Before You Start

1. **Search existing issues** to avoid duplicates
2. **Open an issue** to discuss major changes
3. **Test your changes** in an isolated environment
4. **Follow the code of conduct** (be respectful and professional)

### Code Samples

When contributing code samples:

- ✅ **Test thoroughly** in isolated VMs
- ✅ **Add clear comments** explaining functionality
- ✅ **Include safety warnings** in file headers
- ✅ **Provide cleanup scripts** for registry changes
- ✅ **Document prerequisites** and usage instructions
- ❌ **Never include** malicious or harmful code
- ❌ **Never include** real C2 infrastructure or callbacks

### Detection Rules

When contributing detection rules:

- ✅ **Test against known samples** to verify detection
- ✅ **Document false positives** you've identified
- ✅ **Include MITRE ATT&CK** mappings where applicable
- ✅ **Provide usage examples** for different SIEMs
- ✅ **Specify detection level** (low, medium, high, critical)

### Documentation

When contributing documentation:

- ✅ **Use clear, concise language**
- ✅ **Include practical examples**
- ✅ **Add screenshots** where helpful (but not required)
- ✅ **Follow existing formatting** and style
- ✅ **Verify all links** work correctly

---

## 🔧 Development Workflow

### 1. Fork the Repository

Click the "Fork" button at the top right of the repository page.

### 2. Clone Your Fork

```bash
git clone https://github.com/YOUR-USERNAME/The-Greys.git
cd The-Greys
```

### 3. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

**Branch naming conventions:**
- `feature/` - New features or enhancements
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `detection/` - New detection rules

### 4. Make Your Changes

Edit files, add new content, or fix issues.

### 5. Test Your Changes

**For code samples:**
```bash
# Test in isolated VM
# Verify functionality
# Test cleanup scripts
```

**For website changes:**
```bash
# Install Jekyll (if not already installed)
bundle install

# Run local server
bundle exec jekyll serve

# Test at http://localhost:4000/The-Greys/
```

### 6. Commit Your Changes

```bash
git add .
git commit -m "Brief description of changes"
```

**Commit message guidelines:**
- Use present tense ("Add feature" not "Added feature")
- Be descriptive but concise
- Reference issue numbers if applicable (#123)

### 7. Push to Your Fork

```bash
git push origin feature/your-feature-name
```

### 8. Create a Pull Request

1. Go to your fork on GitHub
2. Click "Pull Request"
3. Select your branch
4. Fill out the PR template
5. Submit for review

---

## 📝 Pull Request Template

When creating a PR, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Detection rule
- [ ] Code sample

## Testing
Describe how you tested your changes

## Checklist
- [ ] Code tested in isolated environment
- [ ] Documentation updated
- [ ] No sensitive information included
- [ ] Safety warnings added where needed
- [ ] Links verified
- [ ] Follows project style guidelines
```

---

## 🔒 Security Considerations

### What NOT to Include

- ❌ Real malware samples or payloads
- ❌ Actual C2 infrastructure details
- ❌ Credentials or API keys
- ❌ Personal or sensitive information
- ❌ Exploits for unpatched vulnerabilities

### What TO Include

- ✅ Educational code samples
- ✅ Benign test handlers
- ✅ Detection rules and hunting queries
- ✅ Defensive strategies
- ✅ Proper safety warnings

---

## 🎨 Style Guidelines

### Markdown Files

- Use ATX-style headers (`#` not underlines)
- Include blank lines between sections
- Use code fences with language specifiers
- Keep lines under 120 characters when possible

### Code Samples

**Registry Files (.reg):**
```reg
Windows Registry Editor Version 5.00

; ============================================================================
; Description of what this file does
; ============================================================================
; 
; USAGE: How to use this file
; WARNING: Safety warning
; ============================================================================

[HKEY_CURRENT_USER\Software\Classes\sample]
@="URL:Sample Protocol Handler"
"URL Protocol"=""
```

**PowerShell Scripts:**
```powershell
# ============================================================================
# Script Name and Purpose
# ============================================================================

# Clear description of what this does
# Usage instructions
# Safety warnings

# Your code here with comments
```

---

## 🧪 Testing Requirements

### Code Samples
- [ ] Tested in Windows 10 VM
- [ ] Tested in Windows 11 VM
- [ ] Cleanup verified
- [ ] No errors or warnings

### Detection Rules
- [ ] Tested against known samples
- [ ] False positives documented
- [ ] Works in target SIEM/tool

### Website Changes
- [ ] Tested locally with Jekyll
- [ ] Links verified
- [ ] Mobile responsive
- [ ] No console errors

---

## 📞 Getting Help

Need help with your contribution?

- **Open a Discussion:** For questions and ideas
- **Join Issues:** Comment on existing issues
- **GitHub:** [@a7t0fwa7](https://github.com/a7t0fwa7)

---

## 🏆 Recognition

Contributors will be:
- Listed in project acknowledgments
- Credited in relevant documentation
- Mentioned in release notes

---

## 📜 Code of Conduct

### Our Standards

- ✅ Be respectful and professional
- ✅ Welcome newcomers
- ✅ Accept constructive criticism
- ✅ Focus on what's best for the community
- ❌ No harassment or discrimination
- ❌ No trolling or insulting comments

---

Thank you for contributing to BYOPH and helping the security community! 🎉

