# Contributing to cat2-notes-gen

Thanks for considering a contribution. This plugin exists to make CAT-2 exam prep faster and more consistent.

## Ways to contribute

- **Report bugs** — open an issue with the exact command you ran, expected output, and actual output.
- **Suggest a template variant** — if you need a different UI (colored, Letter page, sans-serif), open an issue first to discuss.
- **Improve docs** — small typo fixes are always welcome via PR.
- **Add an example** — add a folder under `examples/<subject>-cat2/` with `input-scope.md` and generated HTML.

## Development workflow

1. Fork the repo and clone your fork.
2. Create a branch: `git checkout -b feat/your-change`.
3. Make your change.
4. Run the local validation (see below).
5. Commit with a conventional message: `feat:`, `fix:`, `docs:`, `chore:`.
6. Open a PR against `main`.

## Local validation

```powershell
# JSON manifests parse
Get-Content .claude-plugin\plugin.json | ConvertFrom-Json | Out-Null
Get-Content .claude-plugin\marketplace.json | ConvertFrom-Json | Out-Null

# Skill frontmatter intact
Get-Content skills\cat2-notes-gen\SKILL.md -TotalCount 1   # should print ---

# Template has all required classes
Select-String -Path template\notes-template.html -Pattern '\.callout\.formula|\.hot\b|\.final\b|\.justify\b'
Code of conduct
Be kind. Assume good faith. Focus on the work.
