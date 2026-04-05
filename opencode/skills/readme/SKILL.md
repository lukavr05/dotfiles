---
name: readme
description: Write or update a comprehensive README by examining project structure, dependencies, and source — use when creating or improving a README.md
license: MIT
---

## Before writing anything

Do all of this first. Do not start drafting until you have answered every point.

**Project structure**
- Walk the directory tree (at least 2–3 levels deep)
- Identify the entry point(s) — `main.*`, `index.*`, `app.*`, `cmd/`, `bin/`, etc.
- Note the folder conventions used (e.g. `src/`, `lib/`, `packages/`, `internal/`)

**Dependencies**
- Read the dependency manifest (`package.json`, `go.mod`, `pyproject.toml`, `Cargo.toml`, `requirements.txt`, `Gemfile`, etc.)
- Distinguish runtime deps from dev/build deps
- Identify the framework if any — this shapes the setup instructions significantly
- Note the minimum required runtime version (Node, Python, Go, Rust, etc.)

**Configuration**
- Look for `.env.example`, `config.*`, or any documented environment variables
- List every required env var and what it does
- List optional env vars with their defaults

**Existing docs**
- Read any existing `README`, `CONTRIBUTING`, `CHANGELOG`, `docs/` folder
- Don't discard content that's still accurate — preserve and improve it

**Scripts and commands**
- Read the scripts section of the manifest, `Makefile`, `justfile`, `taskfile`, etc.
- Understand what each does before documenting it

---

## Structure to produce

Use this order. Omit a section only if it genuinely does not apply — note why if it's surprising.

```
# Project Name

One-sentence description — what it does and who it's for.

## Overview
2–4 sentences expanding on what problem this solves and what makes it 
notable. Not a feature list — focus on the purpose and context.

## Prerequisites
Runtime versions, OS requirements, required global tools.

## Installation
Step-by-step from a clean machine to a working local copy.
Use fenced code blocks for every command.

## Configuration
Table of all environment variables:
| Variable | Required | Default | Description |
|----------|----------|---------|-------------|

## Usage
The most common way to run or use the project.
Show real commands with realistic example input/output.
Cover the 2–3 most important use cases — not an exhaustive API reference.

## Project Structure
Annotated tree of the key directories/files.
Skip generated files, lock files, and anything self-explanatory.

## Development
How to run tests, linters, and the dev server.
Contribution notes if relevant (or link to CONTRIBUTING.md).

## Deployment
If applicable — how to build for production and what to consider.

## License
One line. Link to LICENSE file.
```

---

## Writing rules

**Tone and clarity**
- Write for someone smart who has never seen this codebase
- Use active voice and short sentences
- Every command shown must actually work — verify against what you read in the source
- Never write "simply", "just", "easy", or "straightforward"

**Code blocks**
- Always specify the language for syntax highlighting
- Use `bash` for shell commands, not `sh` or `shell` unless there's a real reason
- For multi-step sequences, use numbered prose + one code block per logical step rather than one giant block

**Prerequisites vs Installation**
- Prerequisites: things that must already exist before starting (Node 20+, Docker, a Postgres instance)
- Installation: the steps the user actually runs in this repo

**Environment variables**
- Always use a table — it's scannable
- If there's an `.env.example`, every variable in it must appear in the table
- Mark required vs optional explicitly; never make the reader guess

**Project structure section**
- Use an annotated tree, not prose:
  ```
  src/
  ├── api/          # Express route handlers
  ├── db/           # Prisma schema and migrations
  ├── services/     # Business logic, no HTTP concerns
  └── utils/        # Shared helpers
  ```
- Include only directories and files a new contributor would need to orient themselves
- Skip: lock files, generated output, dotfiles unless they're important

**Accuracy over completeness**
- A shorter README that is fully accurate is better than a long one with stale or wrong steps
- If you're uncertain about something (e.g. a flag's behaviour), say so with a `> ⚠️ Note:` rather than guessing
- If the project is missing something that would normally be documented (e.g. no test command exists), note it rather than omitting the section silently

---

## Badges (optional)

Add these only if the infrastructure actually exists — never add a badge that will show failing or unknown:
- CI status (GitHub Actions, CircleCI, etc.)
- npm/PyPI/crates.io version
- License
- Coverage (only if a coverage service is configured)

Format:
```md
[![CI](https://github.com/org/repo/actions/workflows/ci.yml/badge.svg)](...)
```

Place badges between the project name and the overview paragraph.