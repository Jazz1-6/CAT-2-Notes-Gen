# Customization Guide

How to adapt the exam-notes-generator skill for different subjects, universities, and exam formats.

## Changing the UI

The template's look and feel is entirely controlled by the style block at the top of `template/notes-template.html`. To change the appearance:

1. **Colors**: the design is intentionally monochrome. If you want color, change the values in the `.callout.*` rules (each has a `border-left` and `background` you can tint).
2. **Fonts**: replace the `font-family` on `body`, `h1`, `h2`, and `pre`.
3. **Page size**: change the page size from A4 to Letter or another format.
4. **Margins**: change the page margin values.
5. **Page numbers**: the bottom-center rule controls the footer. Change the text between the quotes.

Keep the class names (`.callout`, `.formula`, `.whatif`, `.mistake`, `.hot`, `.output`, `.final`, `.justify`) so the CSS applies to the content.

## Changing the HOT question format

The HOT question structure lives in the `.hot` block near the bottom of the template. The structure is:

- `div.hot` wrapper
- `div.qheader` with `qnum`, `tag`, `marks` spans
- `div.question` for the question text
- `div.answer-label` with "Answer:"
- `ol.steps` with numbered reasoning steps
- `div.output` for the OUTPUT block
- `div.final` for FINAL ANSWER
- `div.justify` for the Justify line

Modify this if your exam format is different:

- **MCQ exams**: replace "Answer:" with "Correct answer:" and drop the numbered steps.
- **Long-answer exams**: keep the steps but drop the OUTPUT block.
- **Compute-only questions**: keep the steps, drop the question text emphasis.

## Changing the count of HOT questions

Default: 8-14 per module. To change:

- Open `SKILL.md` (for Claude) or `PROMPT.md` (for other agents).
- Find the line "8-14 HOTs per module" and change the range.
- Re-commit.

## Adapting for a specific university

If you're targeting one university's exam style:

1. Collect 3-4 past papers from that university.
2. Identify the recurring question patterns (multi-part, justify tail, sensitivity twist).
3. Document those patterns in a `docs/UNIVERSITY-STYLE.md` file in the repo.
4. Reference that file in `SKILL.md`.

## Adapting for a specific subject

For **theory-only subjects** (no code):

1. In `template/notes-template.html`, the code block is optional. Skip it per topic.
2. Every other section (formula box, worked example, HOTs) still applies.

For **math-heavy subjects**:

1. Use the `.formula` callout for theorems and proofs.
2. Worked examples become proof walkthroughs.

For **language/literature subjects**:

1. The "code block" becomes a quote or key passage.
2. The "worked example" becomes an analysis.

## Adding a new language (code samples)

The template uses generic `pre` blocks. To add syntax highlighting for a specific language, you'd need to inject a highlighter (like Prism.js). This is not currently supported — the design is intentionally monochrome for print. If you want it, see `docs/TROUBLESHOOTING.md`.

## Adding page anchors / hyperlinks

If the PDF will be used digitally (not printed), you can add anchor links in the TOC. This requires:

1. Adding `id` attributes to each heading.
2. Updating the TOC list items to anchor links.

The print version ignores hyperlinks; the digital version uses them.