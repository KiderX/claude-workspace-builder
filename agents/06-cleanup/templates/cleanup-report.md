# Cleanup Report — [Project Name]

**Date:** YYYY-MM-DD

---

## Removed

| Item | File | Reason |
|------|------|--------|
| `import os` | `module.py:3` | Unused import (confirmed by ruff) |
| `def debug_dump()` | `utils.py:45` | Zero callers (grep confirmed) |

---

## Skipped (false positives)

| Item | File | Reason |
|------|------|--------|
| `dynamic_loader` | `utils.py:12` | Called via `importlib` at runtime |

---

## Test results after cleanup

- Total: N | Passed: N | Failed: 0 | Skipped: N
- Coverage: N%

---

## Follow-up

- [ ] Deps/Docs agent re-run required: **Yes** — dependency entries may now be orphaned
