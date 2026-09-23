---
description: Generate CAT-2 exam notes without HOT practice questions
---

Use the `cat2-notes-gen` skill to build a reference-only version of exam notes (no HOT practice questions).

Gather from the user:
- Subject name
- Scope (which modules/units to cover, what to exclude)
- Code language (or "none")
- Output directory

Follow the procedure in `skills/cat2-notes-gen/SKILL.md` but skip Step 4 (HOT questions) and skip the no-HOTs derivation step. Produce only:

- `notes-nohots.html` — topic content, no HOT practice section
- `notes-nohots.pdf` — rendered from the HTML

Render with the appropriate `scripts/convert-*` command for the user's OS. Verify even page count. Report paths and page count.