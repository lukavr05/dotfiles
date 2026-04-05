---
name: debug
description: Systematic approach to diagnosing bugs — use when investigating unexpected behaviour
license: MIT
---

## Process

1. **Reproduce it** — confirm you can trigger it reliably before touching anything
2. **Isolate it** — narrow down which layer, file, or function is responsible
3. **Hypothesise** — write down 2–3 plausible causes before reading more code
4. **Verify, don't assume** — add logging or a debugger breakpoint; don't guess
5. **Fix minimally** — change the least amount necessary to fix the root cause
6. **Confirm the fix** — re-run the reproduction steps; check related paths too

## Common traps to check first
- Off-by-one in loops or pagination
- Async timing / unhandled promise rejections
- Mutation of shared state
- Wrong environment variable or config value
- Stale cache (build cache, node_modules, browser cache)
- Type coercion surprises (`==`, falsy checks on `0` or `""`)

## Output format when reporting a bug
```
**Symptom:** what the user/test sees
**Root cause:** what's actually wrong
**Fix:** what was changed and why
**Regression risk:** anything adjacent that could break
```