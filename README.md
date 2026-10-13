# cat2-notes-gen

An agent skill that generates print-optimized CAT-2 exam-notes PDFs from a syllabus, scope, and constraints. Designed for open-book HOTs (Higher Order Thinking) exams with a fixed, readable, print-friendly UI.

## What it does

Given a subject's syllabus + scope, this skill produces:

- **`notes.html`** â€” the full study version (topic content + worked traces + HOT practice questions)
- **`notes-nohots.html`** â€” same content, HOT practice questions removed (for quick reference during the exam)
- **`notes.pdf`** + **`notes-nohots.pdf`** â€” print-ready PDFs via headless browser
- Both PDFs respect **even page count** for two-sided printing

## What makes it different

- **Fixed UI** â€” Georgia serif body, monochrome, thin gray borders, bold inline labels (`WHY YOU'D USE THIS`, `WHAT IFâ€¦?`, `COMMON MISTAKE`, `ANALOGY`, `KEY RULES`). No colored callout boxes, no decorative bloat. Survives black-and-white printing.
- **Structure per topic** â€” "In one sentence" summary â†’ analogy â†’ why you'd use it â†’ key rules / formula box â†’ code â†’ worked example with numbered steps â†’ what-if companion â†’ common mistake.
- **HOT question format** â€” `Q1 [Tag]` header â†’ question text â†’ `Answer:` â†’ numbered reasoning steps â†’ code â†’ `OUTPUT` block â†’ `FINAL ANSWER â€”` boxed â†’ `Justify:` closing.
- **Cheat-sheet section** â€” cram sheet, master formula sheet, stability quick-reference, tie-break rules, exam-day checklist.

## Installation

### As a Claude Code plugin

1. In Claude Code: `/plugin marketplace add Jazz1-6/CAT-2-Notes-Gen`
2. Then: `/plugin install cat2-notes-gen@cat2-notes-gen-marketplace`
3. Run `/cat2-notes` to generate notes.

### As a Claude Skill (folder)

1. Copy this repo into your Claude Skills directory (usually `~/.claude/skills/cat2-notes-gen/`).
2. Restart Claude (or reload skills).
3. Ask: *"Generate exam notes for [subject], Module Xâ€“Y"*.

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
> - Exam type: Open book, 5 HOTs questions Ã— 10 marks
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

- `skills/cat2-notes-gen/SKILL.md` â€” Claude Skills-compatible definition
- `PROMPT.md` â€” generic agent prompt
- `template/notes-template.html` â€” the HTML/CSS skeleton
- `scripts/convert-*.sh` / `convert-*.bat` â€” headless browser PDF renderers
- `examples/dsa-cat2/` â€” worked example (DSA Module 3+4)
- `docs/` â€” customization, design notes, troubleshooting

## Requirements

- **Node.js** not required.
- **A headless browser** â€” Microsoft Edge (Windows) or Google Chrome (Mac/Linux). Both ship with the OS or are free.
- **No external libraries.** The HTML is self-contained; the scripts are 3 lines each.

## License

MIT â€” see `LICENSE`.

## Credits

UI structure inspired by a university Java study guide (see `docs/SKILL-DESIGN.md`). Content procedurally generated.
