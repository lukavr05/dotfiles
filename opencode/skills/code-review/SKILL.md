---
name: code-review
description: Review code changes for bugs, design issues, and style — use when asked to review a diff or file
license: MIT
---

## Priority order
1. **Correctness** — bugs, off-by-ones, null/error cases, race conditions
2. **Security** — injection, unvalidated input, secrets in code, overly broad permissions
3. **Design** — single responsibility, unnecessary coupling, missing abstractions
4. **Performance** — obvious inefficiencies (N+1 queries, unnecessary allocations)
5. **Readability** — naming, complexity, missing comments on non-obvious logic
6. **Style** — only flag if it's genuinely confusing, not just personal preference

## Format for feedback
Prefix each comment with its severity:
- `[blocker]` — must fix before merge
- `[suggestion]` — worth changing, not a dealbreaker
- `[nit]` — minor, take or leave it
- `[question]` — genuinely unsure, asking for clarification

## What not to do
- Don't rewrite everything in your preferred style
- Don't flag things already handled by the linter/formatter
- Do acknowledge what's done well — not every comment needs to be negative