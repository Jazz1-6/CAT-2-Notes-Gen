---
name: exam-notes-generator
description: Generates print-optimized exam-notes HTML and PDF files from a syllabus, scope, and constraints. Designed for open-book HOTs (Higher Order Thinking) exams with a fixed monochrome UI, structured per-topic content, and a specific HOT question format. Use when the user asks for exam notes, revision notes, study notes, or reference material for an academic exam.
---

# Exam Notes Generator

Generate print-optimized exam-notes documents (HTML + PDF) from a syllabus and scope. Output is monochrome, uses a Georgia serif body, thin gray borders, bold inline labels, and a fixed structure designed for open-book HOTs exams.

## When to use this skill

Trigger this skill when the user asks for any of:

- "Make exam notes for [subject]"
- "Generate study notes for Module X-Y of [course]"
- "Print-friendly revision notes for [subject]"
- "Notes for open-book exam on [subject]"
- "Reference material for [exam type] on [subject]"
- Similar phrasing implying study, revision, or reference material for an academic exam.

Do NOT use for:

- Blog posts, tutorials, general documentation.
- Content that isn't tied to an academic exam.
- One-off explanations of a single concept.

This skill is specifically for exam preparation across a whole subject scope.

## Inputs to request from the user

Ask for these if not already provided. Do not proceed with defaults until the user confirms.

1. Subject — course name (e.g. "Data Structures and Algorithms", "Operating Systems", "Discrete Mathematics").
2. Scope — which modules / units / chapters to cover. List the specific topics. Also ask what to exclude.
3. Code language — C, Python, Java, pseudocode, or "none" (for theory-only subjects).
4. Exam type — Open book / closed book, question format (HOTs, MCQ, long answer, mixed), marks structure if known.
5. Print target — page count range. Even or odd total. Two-sided printing?
6. UI reference (optional) — an existing notes PDF or HTML the user wants the output to resemble.
7. Past papers (optional) — attached past exams the user wants to shape the question style.
8. Output path — where to save the files. Default: current directory.

Do not proceed until the user has confirmed the scope and constraints.

## Output files

Always produce four files:

| File | Purpose |
|---|---|
| notes.html | Full version with topic content + HOT practice questions |
| notes-nohots.html | Same content, HOT practice sections removed |
| notes.pdf | Rendered from notes.html |
| notes-nohots.pdf | Rendered from notes-nohots.html |

Both PDFs must have an even page count for two-sided printing. If a rendering lands on an odd count, add a page break before the last major section to force a new page, then re-render.

## The fixed structure (do not deviate)

Each topic section must contain, in this order:

1. Heading — numbered (3.1, 3.2, 3.3, ...).
2. "In one sentence:" — one-line plain-English summary of the concept.
3. Definition — 2-4 sentences explaining the concept properly.
4. Analogy callout (optional) — a real-world comparison that makes the concept click.
5. "Why you'd use this" callout — practical scenarios where the topic is the right tool.
6. "Key rules" formula box — the essential formulas, invariants, complexities.
7. Code block — in the requested language, with inline comments every 2-3 lines. Skip if the user specified "no code".
8. Worked example — numbered steps + a trace table + FINAL ANSWER boxed line + Justify closing line.
9. "What if...?" callout — a perturbation to the worked example and how the answer changes.
10. "Common mistake" callout — the highest-frequency error students make on this topic.

## HOT question format (must match exactly)

Q# [Tag]                                              X marks
Question text...

Answer:
1. Numbered reasoning step.
2. Numbered reasoning step.
3. Numbered reasoning step.

[code block if applicable]

OUTPUT
[output block if applicable]

FINAL ANSWER — One committed line.

Justify: One or two lines on why.

Tag is one of: [Conceptual], [Trace], [Compute], [Comparison], [Design].

Aim for 8-14 HOTs per module, weighted by exam likelihood if past papers were provided. Trace and Compute questions are the highest priority for typical HOTs exams.

## Procedure

### Step 1 — Confirm scope

Restate the subject, scope, exclusions, and constraints back to the user. Ask them to confirm before proceeding. Do not start generating content until confirmation is received.

### Step 2 — Draft the topic list

Enumerate every topic from the syllabus that's in scope. Number them (3.1, 3.2, ...). Show this list to the user as part of the confirmation.

### Step 3 — Fill the per-topic structure

For each topic, fill the 10-part structure from the section above. Pull content from the syllabus. Where the syllabus is thin, expand with standard textbook content for the subject.

Rules:
- No padding. Every paragraph must add exam-relevant information.
- No textbook copying. Write in original phrasing. Facts and formulas are not copyrightable; prose is.
- Tie-break conventions matter. Document the default rule in a dedicated table.
- Code should be exam-writeable. Short, no library magic, comments every 2-3 lines.

### Step 4 — Compose HOT questions

For each module, write 8-14 HOT questions covering the topic list. Weight them by exam likelihood if past papers were provided. Each question must follow the exact format from the section above.

### Step 5 — Add the closing sections

- Cram Sheet — one-page complexity table, key formulas, tie-break rules, stability quick-reference.
- Master Formula Sheet — single table with every formula from all modules.
- Quick Revision Bullets — per-module 8-12 bullet recall list.
- Exam-Day Checklist — 8-12 items.

### Step 6 — Render to HTML

Use the template at `template/notes-template.html`. Fill the FILL slots with your content. Keep every CSS class name exactly as-is so the styles apply.

### Step 7 — Render to PDF

Run the appropriate conversion script:

- Windows: `scripts\convert-windows.bat notes.html notes.pdf`
- Mac: `./scripts/convert-macos.sh notes.html notes.pdf`
- Linux: `./scripts/convert-linux.sh notes.html notes.pdf`

The scripts use a headless browser (Edge on Windows, Chrome on Mac/Linux) to convert HTML to PDF with the correct print settings.

### Step 8 — Verify page count

Open the PDF. Note the total page count. If it's odd, add a page break before the last major section and re-render. Repeat until even.

### Step 9 — Produce the no-HOTs version

Copy notes.html to notes-nohots.html. Delete every HOT question block. Update the title to note it's the no-HOTs version. Render notes-nohots.pdf.

### Step 10 — Report to the user

Give the user:
- Paths to all four output files
- Page counts for both PDFs
- Any content decisions you made
- Anything the user should review

## Content guidelines

- Cram sheet is the most-read page. Put the highest-density useful information there.
- Worked examples are where marks live. Numbered steps, trace tables, FINAL ANSWER, and Justify — never skip these.
- Analogies are cheap and effective. One good analogy per abstract topic goes a long way.
- Common mistakes are gold. Every topic should call out the highest-frequency error.
- What-if companions target HOTs. The perturbation-based "what if" is the most common HOTs question pattern.
- State assumptions. When a question has a tie-break or convention, say so explicitly.

## Customization

- Different UI: replace the style block in template/notes-template.html. Keep the class names (.callout, .formula, .whatif, .mistake, .hot, .output, .final, .justify) so the CSS applies to the content.
- Different HOT format: replace the .hot HTML structure in the template. Keep the surrounding wrapper and class names.
- More/fewer HOTs: adjust the count per module. Default is 8-14.
- Different page size: change the page size from A4 to Letter or another format.

## Edge cases

### Theory-only subject (no code)

Skip the code block in each topic. Keep every other section. The structure still applies — the "worked example" becomes a worked trace or a proof walkthrough.

### Syllabus is a PDF

Extract text first with pdftotext or pandoc. If extraction fails or produces garbled output, ask the user to paste the topic list directly.

### Very long syllabus (>30 topics)

Split into multiple PDFs, one per module. Tell the user. Each PDF gets its own even page count.

### No past papers provided

Infer the question style from the exam type (HOTs, MCQ, etc.) and the topic list. HOTs exams usually feature trace, compute, comparison, and design questions — weight accordingly.

### User wants a specific UI

Request a PDF or HTML sample of the target UI. Adapt the CSS from template/notes-template.html to match the sample's fonts, spacing, and color scheme.

### User wants only one version

Produce only the requested version. Save it as notes.html / notes.pdf. Skip the no-HOTs step.

### Non-English subject

The structure applies to any language. Keep the section labels in English unless the user requests otherwise.

## What this skill does NOT do

- It does not write exam answers for the user to memorize. It organizes existing knowledge into a structured, printable form.
- It does not guarantee exam success. It is a study aid.
- It does not replace reading the prescribed textbook.
- It does not include diagrams or images unless the user explicitly requests them (and provides the source files).

## Verification checklist before returning

- All topics from the in-scope syllabus are covered.
- Excluded modules are absent.
- Every topic has: numbered heading, "In one sentence" line, definition, key rules box, code (if applicable), worked example with FINAL ANSWER and Justify, what-if callout, common mistake callout.
- HOT questions match the exact format (Q# + tag + question + Answer: + numbered steps + code + OUTPUT + FINAL ANSWER + Justify).
- Both PDFs render without errors.
- Both PDFs have an even page count.
- Files are saved to the requested output path.
- The user has been told the paths and page counts.