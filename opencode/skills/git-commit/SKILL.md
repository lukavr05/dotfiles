---
name: git-commit
description: Write conventional commits with good messages — use when staging or committing changes
license: MIT
---

## Format
Use Conventional Commits: `<type>(<scope>): <subject>`

Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `perf`, `ci`

## Rules
- Subject line: imperative mood, no period, max 72 chars
- If the change needs explanation, add a body after a blank line
- Body explains *why*, not *what* — the diff shows what
- Breaking changes: add `!` after type, e.g. `feat!:`, and explain in body
- Never mention file names in the subject unless genuinely necessary

## Examples
```
feat(auth): add OAuth2 login via GitHub

fix(api): prevent crash when response body is empty

refactor(db): extract query builder into separate module

Moves inline SQL strings into a QueryBuilder class.
Motivated by upcoming need to support multiple dialects.
```