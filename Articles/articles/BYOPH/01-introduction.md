# Article 1: The Hidden Attack Surface in Every Click

## Introducing Windows Protocol Handlers

**Series:** Decoding BYOPH (Part 1 of 7)
**Reading time:** 6 minutes
**Skill level:** Beginner to Intermediate

---

## 📝 LinkedIn Post Content

Every time you click `mailto:`, `tel:`, or `zoom://`, Windows executes code on your behalf. But what happens when attackers register their own protocols? Let me show you a technique that flies under most security radars.

I'm starting a 7-part series on "Bring Your Own Protocol Handler" (BYOPH)—a creative attack technique that abuses a legitimate Windows feature. Whether you're on the red team or blue team, understanding this technique will make you better at your job.

---

### 🎯 What You'll Learn Today

✅ What URL protocol handlers actually are (and why they matter)
✅ Why this technique is attractive to adversaries  
✅ The registry locations that control protocol execution
✅ How to start thinking about detection

---

### 💡 The "Aha" Moment

I was reviewing incident response logs when I noticed something unusual—a process spawned from a URL click that wasn't HTTP or HTTPS. The parent process was a browser, but the child was... PowerShell?

That's when I discovered BYOPH.

The attacker had registered a custom URL protocol that, when clicked, executed arbitrary code. No exploit. No vulnerability. Just a legitimate Windows feature doing exactly what it was designed to do—but for malicious purposes.

---

### 🔍 What Are Protocol Handlers?

You use protocol handlers every day without thinking about them:

• `mailto:someone@email.com` → Opens your email client
• `tel:+1234567890` → Opens your phone app
• `steam://run/12345` → Launches a Steam game
• `ms-teams://` → Opens Microsoft Teams
• `zoom://` → Launches Zoom

These aren't magic. They're simply **registry entries** that tell Windows:
> "When you see a URL starting with this scheme, run this program."

The mechanism is straightforward:
1. User clicks a link like `sample://hello`
2. Windows checks the registry for a handler
3. Windows executes the registered command
4. The URL is passed as an argument

---

### ⚠️ Why Defenders Should Care

Here's what makes BYOPH attractive to attackers:

| Factor | Impact |
|--------|--------|
| **No admin required** | HKCU registration works with standard user privileges |
| **Wide attack surface** | Browsers, Office docs, PDFs, email clients can all invoke handlers |
| **User familiarity** | People are conditioned to click links |
| **Persistence** | Once registered, handlers survive reboots |
| **Low detection** | It's a legitimate feature—hard to distinguish good from bad |

---

### 🗂️ Where Handlers Live: The Registry

Protocol handlers are registered in two primary locations:

**Per-User (No Admin Required):**
```
HKEY_CURRENT_USER\Software\Classes\<scheme-name>
```

**System-Wide (Admin Required):**
```
HKEY_LOCAL_MACHINE\SOFTWARE\Classes\<scheme-name>
```

**Critical insight:** If the same scheme exists in both locations, HKCU takes precedence. This means an attacker can **shadow** a legitimate system handler with their own—without admin rights.

---

### 📊 The Attack Chain

Here's how a typical BYOPH attack unfolds:

```
Phase 1: DELIVERY
├── Attacker sends .reg file (via email, download, etc.)
└── User imports the registry file

Phase 2: REGISTRATION  
├── Protocol handler is created in HKCU
└── No admin prompt, no UAC bypass needed

Phase 3: TRIGGERING
├── Attacker sends link (in email, document, webpage)
└── User clicks the link

Phase 4: EXECUTION
├── Windows invokes the registered handler
└── Arbitrary code runs in user context
```

---

### 🛡️ Defender's Preview

If you're on the blue team, start thinking about:

1. **Monitoring** new keys under `HKCU\Software\Classes\` with `URL Protocol` values
2. **Alerting** on suspicious commands (PowerShell, cmd, script hosts)
3. **Training** users to be suspicious of "external application" prompts
4. **Blocking** .reg file downloads from untrusted sources

We'll dive deep into detection in Part 6 of this series.

---

### 📌 Key Takeaways

1. Protocol handlers are a **legitimate Windows feature** that can be abused
2. **HKCU registration requires no administrator privileges**—huge for attackers
3. **Any application** that handles URLs can invoke custom schemes
4. HKCU handlers **take precedence** over HKLM—enabling handler shadowing
5. This technique **combines well** with social engineering

---

### ⚠️ IMPORTANT DISCLAIMER

```
This content is for AUTHORIZED SECURITY TESTING and EDUCATIONAL PURPOSES only.

✓ Always use isolated lab environments
✓ Never test on systems without explicit written authorization  
✓ Follow your organization's rules of engagement
✓ Respect applicable laws (CFAA, Computer Misuse Act, etc.)

Unauthorized access to computer systems is a criminal offense.
```

---

### 🔜 Coming Next Week

In Part 2, I'll dissect **real attack artifacts**—showing you exactly what malicious protocol handlers look like in registry files. You'll learn to extract indicators of compromise and recognize the social engineering patterns attackers use.

**Follow me** to catch the next installment!

---

### 💬 Discussion Question

Have you ever encountered a suspicious protocol handler in an incident response investigation? What tipped you off? Share your experience in the comments!

---

#Cybersecurity #InfoSec #BlueTeam #RedTeam #WindowsSecurity #ThreatHunting #BYOPH #SecurityResearch #IncidentResponse #MalwareAnalysis

