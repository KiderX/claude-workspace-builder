# Global Rules

Loaded by Agent 03 (Engineer) and Agent 04 (Reviewer).
Apply to every file touched in a session.

---

## Code quality

### Python
- Python 3.11+ syntax
- `ruff` for linting and formatting (line length 100, target `py311`)
- `mypy` for type checking (`--ignore-missing-imports`)
- Every function signature has full type annotations — no bare `Any` without a documented reason
- Every public function has a docstring (one-line for simple, Google-style for complex)
- No `TODO` comments — either implement fully or raise a flag to the user
- No `print()` or `pdb.set_trace()` in production code

### JavaScript / TypeScript
- TypeScript strict mode (`"strict": true` in tsconfig)
- ESLint + Prettier
- No `var` — use `const` or `let`
- No implicit `any`
- JSDoc on every exported function

### All languages
- No hardcoded secrets, credentials, or API keys
- No magic numbers — extract to named constants
- No deeply nested logic (more than 3 levels — extract to a function)
- No function over 60 lines (excluding docstrings and blank lines)
- Consistent naming conventions throughout the file

---

## File and path handling (Python)

- All file paths use `pathlib.Path` — never string concatenation
- Text files opened with `encoding="utf-8"`
- Temp files use the `tempfile` standard library module — never write to `/tmp` directly
- No `os.system()` — use `subprocess.run()` with a list of arguments
- No Unix-only shell syntax in subprocess calls

---

## Git hygiene

Never commit:
- `.env` or any file containing real credentials
- `__pycache__/`, `*.pyc`, `*.pyo`
- `node_modules/`
- `.DS_Store`, `Thumbs.db`
- IDE config files (`.idea/`, `.vscode/`) unless explicitly requested

Always present in every project:
- `.gitignore` (covering the above)
- `README.md`
- `.env.example` with placeholder values only

---

## Dependencies

### Python
- All runtime dependencies pinned in `pyproject.toml` with exact versions (`name==x.y.z`)
- All dev dependencies in `[tool.poetry.group.dev.dependencies]`
- Never add a dependency without confirming it has had a release in the past 12 months

### JavaScript / TypeScript
- All production dependencies pinned in `package.json` — no `^` or `~`
- Dev dependencies may use `^` in `devDependencies`

---

## Security non-negotiables

- No secrets in code or committed files — ever
- No `eval()` or `exec()` on user-supplied data
- No f-string or string-concatenated SQL
- Debug mode must be `False` in any production configuration
- CORS must not be set to `*` in production

---

## Communication standards

- When something is ambiguous: ask before proceeding
- When deviating from spec: explain why before doing it
- When blocked: state the blocker and what is needed to unblock — do not silently skip
- Never let a raw Python traceback reach the user in normal operation
