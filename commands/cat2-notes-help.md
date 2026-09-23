---
description: Show how to use the cat2-notes-gen plugin
---

Print this help summary:

**Commands:**
- `/cat2-notes` — generate full notes with HOT practice questions
- `/cat2-notes-nohots` — generate reference-only notes (no HOTs)
- `/cat2-notes-help` — this message

**How it works:** The plugin bundles a prompt, an HTML template, and PDF conversion scripts. When you run a command, Claude Code reads the skill, generates the content in sections (writing to disk as it goes), and runs the headless browser to produce the PDF.

**What you'll get:**
- `notes.html` and `notes.pdf` (full version)
- `notes-nohots.html` and `notes-nohots.pdf` (reference version)

**Requirements:** A headless browser — Edge on Windows, Chrome on Mac/Linux. The `scripts/convert-*` files handle this automatically.

**For more info:** see `README.md` and `docs/CUSTOMIZATION.md` in the plugin repo.