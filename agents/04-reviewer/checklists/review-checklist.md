# Code Review Checklist

Mark each item: ✅ Pass | ❌ Fail (file:line) | N/A

---

## Security

- [ ] No hardcoded secrets, API keys, passwords, or tokens in any file
- [ ] `.env` is listed in `.gitignore`
- [ ] `.env.example` exists and contains only placeholder values
- [ ] All user inputs are validated before use
- [ ] SQL queries use parameterised statements (no f-string or string-concat SQL)
- [ ] No `eval()` or `exec()` on user-supplied data
- [ ] Error responses do not leak stack traces or internal paths

## Code quality

- [ ] No function exceeds 60 lines (excluding docstrings and blank lines)
- [ ] No logic nested more than 3 levels deep
- [ ] Naming conventions are consistent throughout the codebase
- [ ] No magic numbers — constants are named and documented
- [ ] No dead code (unreachable branches, unused variables)
- [ ] No commented-out code blocks

## Type safety

- [ ] Every function has full type annotations
- [ ] No untyped `Any` without a documented reason
- [ ] Return types are explicit on every function
- [ ] Optional values are handled explicitly (no silent `None` propagation)

## Documentation

- [ ] Every public function has a docstring
- [ ] Every module has a module-level docstring
- [ ] Complex logic has a comment explaining *why*, not *what*

## Testing

- [ ] At least one test exists per public function
- [ ] Tests cover the happy path
- [ ] Tests cover at least one error/edge case per function
- [ ] No test uses `time.sleep()` to wait for async operations
- [ ] No test writes to a real database, filesystem, or external service without mocking

## Dependencies

- [ ] Every import resolves to a package listed in `pyproject.toml` / `package.json`
- [ ] No circular imports
- [ ] No relative imports that escape the package boundary

## Cross-platform (Python projects)

- [ ] All file paths use `pathlib.Path` (no string concatenation)
- [ ] No Unix-only shell syntax in subprocess calls
- [ ] Text files opened with `encoding="utf-8"`
- [ ] No `/tmp` — uses `tempfile` module instead
- [ ] No `os.system()` — uses `subprocess.run()` with list args
