# Skill Design Notes

Why this skill is structured the way it is.

## Why a template, not a generator

An LLM can write exam notes without a template. But every output would look different — different fonts, different spacing, different structure. A template guarantees:

1. Consistency across subjects. Notes for OS and notes for DSA look and feel the same.
2. Print optimization. The CSS is tuned for A4 two-sided printing with even page counts.
3. Readability. The monochrome design survives black-and-white printing without losing meaning.

The template is the reusable asset. The content is generated per-request.

## Why monochrome

Colored callout boxes look nice on screen but become muddy on black-and-white printers. Using gray borders and bold inline labels preserves meaning in both contexts:

- WHY YOU'D USE THIS as bold text survives.
- Yellow background does not.

The design decision is: never encode information in color. Encode it in structure.

## Why the per-topic structure is fixed

The sequence summary → definition → analogy → why → formula → code → example → what-if → mistake is derived from how students actually read during exams:

1. First pass: read the "In one sentence" summary. If you know it, skip.
2. Second pass: read the definition + formula box. If you need more, keep reading.
3. Deep dive: read the analogy, why, worked example, what-if, mistake.

Every section answers a different question the student might have. The order goes from highest-level to lowest-level detail.

## Why the HOT format is what it is

The HOT format (Q# → question → Answer: → steps → code → OUTPUT → FINAL ANSWER → Justify) mirrors what university HOTs exams actually demand:

- Numbered steps show reasoning, not just the answer.
- OUTPUT block separates what happens from what you conclude.
- FINAL ANSWER forces commitment.
- Justify is where the reasoning marks live — past-paper analysis shows this is consistently 20-30% of the marks.

The format is not arbitrary. It's shaped by what gets graded.

## Why two output versions (with and without HOTs)

In the exam:

- With HOTs = study material. Read it before the exam to practice question types.
- Without HOTs = reference material. Print only this for the exam; less to flip through.

Same content, different purpose. The generator produces both automatically.

## Why even page count is enforced

Two-sided printing wastes a sheet if the page count is odd. Enforcing even means:

- 36-page PDF = 18 sheets, no waste.
- Odd page count forces a blank back side.

The agent adds a spacer if needed. Trivial to do, saves paper.

## Why no syntax highlighting

Considered and rejected. Reasoning:

1. Print output is black and white — highlighting degrades to gray mush.
2. The visual chunking that highlighting provides can be achieved with blank lines between logical blocks, right-side comments, and bold identifiers.
3. On screen, Ctrl+F works fine without color.

The design trades color for print fidelity.

## Why MIT license

The skill is meant to be used by students for their own subjects, forked and adapted by others, and modified for different universities. MIT allows all three with zero friction.

## What this skill is not

- Not a study plan. It organizes content; it doesn't schedule your study.
- Not a tutor. It presents information; it doesn't quiz you interactively.
- Not a replacement for the textbook. It's a cram aid.
- Not a guarantee of marks. It's an input to your own study process.