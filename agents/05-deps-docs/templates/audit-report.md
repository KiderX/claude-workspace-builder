# Deps/Docs Audit Report — [Project Name]

**Date:** YYYY-MM-DD  
**Run:** [Post-Engineer | Post-Cleanup]

---

## Dependency changes

### Added to pyproject.toml / package.json

| Package | Version | Section | Reason |
|---------|---------|---------|--------|
| `package` | x.y.z | dependencies | [why] |

### Flagged as potentially unused

| Package | File | Note |
|---------|------|------|
| `package` | pyproject.toml | No import found — pass to Cleanup agent |

---

## README.md changes

| Section | Change description |
|---------|--------------------|
| Installation | Updated Poetry install command to match pyproject.toml |
| ...     | ...                |

<!-- Write "No changes required" if README was already accurate -->

---

## Follow-up actions required

- [ ] Run `poetry lock --no-update` to update the lock file
- [ ] Commit updated `pyproject.toml` and `poetry.lock` together
