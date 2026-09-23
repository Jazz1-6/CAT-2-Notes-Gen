# Troubleshooting

Common issues with the exam-notes-generator skill and how to fix them.

---

## PDF conversion fails

### "File not found" error shown inside the PDF

Symptom: The PDF opens, but its content is the browser's "File not found" page instead of the notes.

Cause: The `file:///` URL passed to the headless browser does not point at a real HTML file. Usually a filename mismatch — wrong case, missing extension, or the file is in a different folder than the URL assumes.

Fix:
1. Confirm the HTML file exists: `dir /b C:\path\to\notes.html`
2. Confirm the URL in the conversion command matches the exact filename.
3. If in doubt, rename the HTML file to something simple like `notes.html` and use that name in both places.

---

### "Failed to write file ... Access is denied (0x5)"

Symptom: The headless browser prints an error like `Failed to write file X.pdf: Access is denied.` and no PDF is produced.

Cause: The output PDF is locked by another process — a PDF viewer with it open, a stale headless browser holding the file handle, or antivirus scanning.

Fix on Windows:

taskkill /F /IM msedge.exe
taskkill /F /IM chrome.exe
del C:\path\to\output.pdf

Then re-run the conversion command.

Fix on Mac/Linux:

pkill -f "Google Chrome"
pkill -f "msedge"
rm -f /path/to/output.pdf

Then re-run the script.

---

### "No compatible browser found"

Symptom: The conversion script prints an error and exits.

Cause: Neither Microsoft Edge nor Google Chrome is installed at the expected path.

Fix:
- Windows: Edge ships with Windows 10 and 11. If missing, install from https://www.microsoft.com/edge. Or install Google Chrome.
- Mac: Install Google Chrome from https://www.google.com/chrome/.
- Linux: Install chromium-browser (Debian/Ubuntu) or chromium (Fedora).

The script auto-detects after reinstall.

---

### Empty or blank PDF

Symptom: The PDF opens but every page is blank, or the file is under 10 KB.

Cause: Either the HTML file is empty, or the browser failed to render CSS.

Fix:
1. Open the HTML in a regular browser (double-click it).
2. If the browser shows the notes correctly, the HTML is fine — re-run the conversion.
3. If the browser shows a blank page, the HTML is broken. Regenerate it.

---

### PDF renders but styles are missing

Symptom: The PDF has content, but tables have no borders, callout boxes are missing, fonts are default.

Cause: The CSS block at the top of the HTML is missing or malformed.

Fix: Verify the style block is present and starts immediately after the head tag. If accidentally deleted, restore from `template/notes-template.html`.

---

## Content issues

### HOT questions don't match the required format

Symptom: Questions are missing the numbered steps, OUTPUT block, or FINAL ANSWER line.

Cause: The agent producing the notes didn't follow the HOT format spec.

Fix:
1. Open `SKILL.md` (for Claude) or `PROMPT.md` (for other agents).
2. Locate the "HOT question format" section.
3. Re-paste the format block into your prompt as an explicit reminder.

---

### Pages are cramped / hard to read

Symptom: Text feels squeezed, lines run together, reading is uncomfortable.

Cause: The base font is too small or line-height is too tight.

Fix: In `template/notes-template.html`, find the body rule and adjust font-size to 10pt or 10.5pt, and line-height to 1.5. Re-render. Page count will increase — verify it's still even.

---

### Code blocks overflow the right edge

Symptom: Code lines are cut off at the right margin.

Cause: Very long lines in the code, or CSS overriding white-space.

Fix: The template uses pre-wrap and break-word. If lines still overflow, shorten them or reduce code font size to 7.8pt.

---

### Tables split awkwardly across pages

Symptom: A table starts at the bottom of one page and continues at the top of the next.

Cause: The table is too tall to fit on one page.

Fix: The template already sets page-break-inside: avoid on tables. If a single table is genuinely taller than one page, split it into two tables with their own headings.

---

### Page count is odd

Symptom: The PDF has an odd number of pages. Printing two-sided wastes the last sheet's back side.

Fix: Add a page break before the last major section to force a new page. This pushes the total to the next even number. Re-render.

---

### Callout boxes render but text is missing

Symptom: Gray boxes appear but the label or body text is empty.

Cause: The callout-label or callout-body spans are empty in the HTML.

Fix: Check the source HTML. Every callout must have both spans filled.

---

## Installation issues

### Claude doesn't recognize the skill

Symptom: You placed SKILL.md in the skills folder but Claude doesn't trigger it.

Cause: Malformed frontmatter, wrong directory, or unregistered skill.

Fix:
1. Verify the frontmatter starts and ends with three dashes.
2. The name field must exactly match the folder name (lowercase, hyphens).
3. Restart Claude or reload skills from the UI.

---

### Generic agent ignores the format

Symptom: The LLM produces notes but not in the expected structure.

Cause: The prompt doesn't include the full procedure, or it was summarized.

Fix: Paste the entire contents of PROMPT.md into the system prompt — not just a summary.

---

## Git / repository issues

### Rendered PDFs are not in the repo

Cause: .gitignore excludes *.pdf by default.

Fix: Uncomment the *.pdf line in .gitignore if you want PDFs versioned. Or keep them out and only commit HTML sources.

---

### Committed a .DS_Store or Thumbs.db accidentally

Fix:

git rm --cached .DS_Store Thumbs.db
git commit -m "Remove OS files"

The .gitignore already excludes future ones.

---

### Scripts are not executable on Mac/Linux

Symptom: `./scripts/convert-macos.sh: Permission denied`

Fix:

chmod +x scripts/convert-macos.sh scripts/convert-linux.sh
git update-index --chmod=+x scripts/convert-macos.sh scripts/convert-linux.sh
git commit -m "Make scripts executable"

---

## Advanced

### Adding syntax highlighting

Not supported by design. To add it: include Prism.js or highlight.js in the HTML head, wrap code in a code element with a language class, add a theme CSS file, then re-render. Expect highlighting to look washed out on black-and-white prints.

---

### Adding page anchors

Print ignores hyperlinks; digital PDFs use them. To add: give each heading an id attribute, then update TOC list items to anchor links.

---

### Rendering to DOCX or EPUB

Use pandoc: `pandoc notes.html -o notes.docx`. Layout will not match the PDF. Expect to re-style for DOCX.

---

### Supporting mixed languages in code blocks

Code blocks are language-agnostic. Note the language in the label above the code block. No special handling needed.

---

### Very large documents

For very long subjects, split into one PDF per module. Generate separate HTML files, render each. Each PDF gets its own even page count.