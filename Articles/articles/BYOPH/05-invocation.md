# Article 5: From Documents to Browsers

## The Many Paths to Protocol Invocation

**Series:** Decoding BYOPH (Part 5 of 7)
**Reading time:** 7 minutes
**Skill level:** Intermediate

---

## 📝 LinkedIn Post Content

A protocol handler is useless until someone clicks a link. But attackers have many options—from Word documents to browser redirects to email links.

Today we explore the full attack surface of protocol invocation.

---

### 🎯 What You'll Learn Today

✅ Invoke handlers from Office documents (Word, Excel, PowerPoint)
✅ Invoke handlers from PDF files
✅ Invoke handlers from web browsers (HTML, JavaScript)
✅ Understand browser security prompts and their limitations
✅ See the full attack surface from a defender's perspective

---

### 🕸️ The Invocation Surface

Protocol handlers can be triggered from almost anywhere that handles URLs:

```
DOCUMENT-BASED                 WEB-BASED
├── Microsoft Word             ├── HTML anchor tags
├── Microsoft Excel            ├── JavaScript redirects
├── Microsoft PowerPoint       ├── Meta refresh tags
├── PDF readers                └── iframes
├── OneNote
└── LibreOffice                OTHER
                               ├── Email clients (Outlook, etc.)
                               ├── Chat apps (Teams, Slack)
                               ├── Note-taking apps
                               └── Any app that renders URLs
```

This wide surface is what makes BYOPH so versatile.

---

### 📄 Document-Based Invocation

**Microsoft Word:**
1. Open Word → New document
2. Type text: "Click here for the portal"
3. Select text → Insert → Link
4. Enter address: `myscheme://payload`
5. Save document
6. When recipient clicks the link → Handler invoked

**The link looks completely normal** in the document. Users can't easily see it's a custom scheme.

**PDF Files:**
• Export from Word: File → Export → Create PDF
• The hyperlink survives the conversion
• PDF readers will invoke the handler when clicked

**PowerPoint:**
• Add hyperlink to any object (shape, text, image)
• Presentation mode: clicking triggers the handler
• Great for "click here to continue" scenarios

---

### 🌐 Browser-Based Invocation

**Method 1: Simple HTML Anchor**
```html
<a href="myscheme://data">Click here</a>
```

**Method 2: JavaScript Location**
```javascript
window.location.href = "myscheme://payload";
```

**Method 3: JavaScript Window.open**
```javascript
window.open("myscheme://payload");
```

**Method 4: Meta Refresh (Auto-redirect)**
```html
<meta http-equiv="refresh" content="0;url=myscheme://auto">
```

**Method 5: Hidden iframe (Sneaky)**
```html
<iframe src="myscheme://background" style="display:none"></iframe>
```

---

### 🚨 Browser Security Prompts

Modern browsers show a confirmation dialog:

```
┌─────────────────────────────────────┐
│  Open myscheme://?                  │
│                                     │
│  An external application is         │
│  required to handle this link.      │
│                                     │
│  ☐ Always allow example.com to      │
│    open myscheme:// links           │
│                                     │
│  [Cancel]            [Open]         │
└─────────────────────────────────────┘
```

**The problem:** Users often click "Open" without thinking, especially if:
• The link text looks legitimate
• They just imported a "configuration" file
• The scheme name sounds trustworthy

**The bigger problem:** That checkbox. If users check "Always allow," future invocations bypass the prompt entirely.

---

### 📊 Browser Behavior Comparison

| Browser | Shows Prompt | Remember Choice | Auto-invoke After |
|---------|--------------|-----------------|-------------------|
| Chrome | Yes | Yes (checkbox) | If checked |
| Edge | Yes | Yes (checkbox) | If checked |
| Firefox | Yes | Yes (checkbox) | If checked |
| Safari | Yes | No | Never |

---

### 🎭 Attack Chain: Phishing + BYOPH

Here's how a real attack might unfold:

```
DAY 1: SETUP
├── Attacker sends email with .reg attachment
├── "Please import this VPN configuration"
└── User imports → Handler registered

DAY 2-30: DORMANT
└── Handler sits in registry, waiting

DAY 31: TRIGGER
├── Attacker sends follow-up email
├── Contains link to legitimate-looking page
├── Page has: <a href="vpn-connect://auth">Connect to VPN</a>
├── User clicks → "Open external app?" → User clicks Open
└── Malware executes
```

**Why the delay matters:**
• Separates suspicious .reg import from execution
• User may forget they imported anything
• Makes correlation harder for defenders

---

### 🛡️ Defense Recommendations

**User Training:**
• Treat .reg files like executables—they enable code execution
• Be suspicious of "Open external application?" prompts
• Never check "Always allow" for unknown schemes

**Technical Controls:**
• Block .reg file downloads at web proxy
• Monitor for .reg files in email attachments
• Alert on new protocol handler registrations
• Consider application whitelisting

**Browser Hardening:**
• Some browsers allow enterprise policies for scheme blocking
• Consider blocking unknown schemes at the browser level
• Audit "always allow" permissions periodically

---

### 🧪 Lab Exercise

In your isolated VM with a registered test handler:

**Exercise 1: Document Invocation**
1. Create a Word document with a link to your test scheme
2. Save, close, and reopen
3. Click the link—observe the behavior
4. Export to PDF and test again

**Exercise 2: Browser Methods**
Create an HTML file and test each method:
```html
<a href="labtest://anchor">Anchor Tag</a>
<button onclick="window.location='labtest://js'">JavaScript</button>
```

**Document your findings:** Which methods show prompts? Which don't?

---

### 📌 Key Takeaways

1. **The attack surface is huge**—any URL-rendering app can invoke handlers
2. **Documents are dangerous**—links in Word/PDF look completely normal
3. **Browser prompts are weak**—users click through them habitually
4. **"Always allow" is permanent**—creates a silent execution path
5. **Time separation** between registration and triggering complicates detection

---

### ⚠️ SAFETY REMINDER

```
Test only with benign handlers!

✓ Use the Notepad or logging handler from Part 3
✓ Never create handlers with network callbacks
✓ Test in isolated VMs only
✓ Clean up all test documents afterward

Educational purposes only.
```

---

### 🔜 Coming Next Week

In Part 6, we switch fully to the blue team perspective: **Detection rules, Sysmon configuration, and incident response procedures**. Time to hunt these handlers!

**Follow me** for Part 6!

---

### 💬 Discussion Question

Which invocation method do you think is most dangerous from a social engineering perspective? Documents, browser links, or something else?

---

#Cybersecurity #Phishing #SocialEngineering #BlueTeam #BYOPH #DocumentSecurity #BrowserSecurity #ThreatHunting #InfoSec #SecurityAwareness

