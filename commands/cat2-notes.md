---
description: Generate CAT-2 exam notes for a subject using the cat2-notes-gen skill
---

Use the `cat2-notes-gen` skill to build print-optimized exam notes.

Gather from the user (ask if not provided):
- Subject name
- Scope (which modules/units to cover, what to exclude)
- Code language (C, Python, Java, or "none")
- Exam type (open book, HOTs, etc.)
- Print target (page count range, even/odd)
- Output directory

Then follow the procedure in `skills/cat2-notes-gen/SKILL.md`:

1. Confirm scope with the user.
2. Draft the topic list.
3. Generate `notes.html` by writing it to disk section by section (cover, cheatsheet, cram sheet, Module topics, HOT questions, closing sections). Each write is a separate file append — do not try to output the whole document in one response.
4. Generate `notes-nohots.html` by copying `notes.html` and removing every HOT question block.
5. Render both to PDF:
   - Windows: `scripts\convert-windows.bat notes.html notes.pdf`
   - Mac: `./scripts/convert-macos.sh notes.html notes.pdf`
   - Linux: `./scripts/convert-linux.sh notes.html notes.pdf`
6. Verify even page count. If odd, add a `<div class="pagebreak"></div>` before the last major section and re-render.
7. Report output paths and page counts to the user.