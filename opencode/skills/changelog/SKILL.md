---
name: changelog
description: Generate or update a CHANGELOG.md entry for a release — use when cutting a new version
license: MIT
---

## Format (Keep a Changelog)
```
[1.2.0] - 31/12/2025
Added
- ...

Changed
- ...

Fixed
- ...

Removed
- ...

```

## Rules
- Use the unreleased section for ongoing work: `## [Unreleased]`
- Entries are for *users*, not developers — avoid internal jargon
- Group by type, most impactful first
- Link version numbers to GitHub compare URLs at the bottom of the file
- Breaking changes go at the top of their section, marked **Breaking:**

## Source material
Derive entries from: merged PR titles, conventional commit log since last tag, and any manually noted items.