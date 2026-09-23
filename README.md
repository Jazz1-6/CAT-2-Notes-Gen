# exam-notes-generator

An agent skill that generates print-optimized exam-notes PDFs from a syllabus, scope, and constraints. Designed for open-book HOTs (Higher Order Thinking) exams with a fixed, readable, print-friendly UI.

## What it does

Given a subject's syllabus + scope, this skill produces:

- **`notes.html`** — the full study version (topic content + worked traces + HOT practice questions)
- **`notes-nohots.html`** — same content, HOT practice questions removed (for quick reference during the exam)
- **`notes.pdf`** + **`notes-nohots.pdf`** — print-ready PDFs via headless browser
- Both PDFs respect **even page count** for two-sided printing

## What makes it different

- **Fixed UI** — Georgia serif body, monochrome, thin gray borders, bold inline labels (`WHY YOU'D USE THIS`, `WHAT IF…?`, `COMMON MISTAKE`, `ANALOGY`, `KEY RULES`). No colored callout boxes, no decorative bloat. Survives black-and-white printing.
- **Structure per topic** — "In one sentence" summary → analogy → why you'd use it → key rules / formula box → code → worked example with numbered steps → what-if companion → common mistake.
- **HOT question format** — `Q1 [Tag]` header → question text → `Answer:` → numbered reasoning steps → code → `OUTPUT` block → `FINAL ANSWER —` boxed → `Justify:` closing.
- **Cheat-sheet section** — cram sheet, master formula sheet, stability quick-reference, tie-break rules, exam-day checklist.

## Installation

### As a Claude Skill

1. Copy this repo into your Claude Skills directory (usually `~/.claude/skills/exam-notes-generator/`).
2. Restart Claude (or reload skills).
3. Ask: *"Generate exam notes for [subject], Module X–Y"*.

### As a generic agent prompt

Copy the contents of `PROMPT.md` into your system prompt for ChatGPT, Cursor, or any other LLM agent.

### Manual use (no agent)

1. Copy `template/notes-template.html`.
2. Fill in the content slots marked with `<!-- FILL: ... -->`.
3. Convert to PDF with the script in `scripts/`.

## Usage

### Minimal request to an agent

> Generate exam notes for DSA, Module 3 and 4. Code in C. Print-friendly. Target ~30 pages. Exclude Module 5.

### Detailed request

> Generate exam notes with these constraints:
> - Subject: Operating Systems
> - Modules: 3 and 4 (CPU Scheduling, Deadlock, Memory, Disk Scheduling, Page Replacement)
> - Code language: none (theory subject)
> - Exam type: Open book, 5 HOTs questions × 10 marks
> - Print target: even page count, ~28 pages
> - Exclusions: Module 5 (MST/Prim's/Kruskal's as standalone)
> - UI reference: [attach example PDF]
> - Past-paper patterns: [attach past papers if available]
>
> Output to `./notes/`.

The skill will:
1. Confirm scope and constraints
2. Draft the topic list
3. Fill the template per topic
4. Generate HOT practice questions in the required format
5. Render the PDFs
6. Verify even page count

## Files

- `SKILL.md` — Claude Skills-compatible definition
- `PROMPT.md` — generic agent prompt
- `template/notes-template.html` — the HTML/CSS skeleton
- `scripts/convert-*.sh` / `convert-*.bat` — headless browser PDF renderers
- `examples/dsa-cat2/` — worked example (DSA Module 3+4)
- `docs/` — customization, design notes, troubleshooting

## Requirements

- **Node.js** not required.
- **A headless browser** — Microsoft Edge (Windows) or Google Chrome (Mac/Linux). Both ship with the OS or are free.
- **No external libraries.** The HTML is self-contained; the scripts are 3 lines each.

## License

MIT — see `LICENSE`.

## Credits

UI structure inspired by a university Java study guide (see `docs/SKILL-DESIGN.md`). Content procedurally generated.