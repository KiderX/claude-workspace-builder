# Security Review Checklist

Mark each item: ✅ Pass | ❌ CRITICAL | ⚠️ WARNING | ℹ️ INFO | N/A

---

## Secrets and credentials

- [ ] No API keys, tokens, or passwords in any committed file
- [ ] No private key blocks in any committed file
- [ ] `.env` is listed in `.gitignore`
- [ ] `credentials.json` (and equivalent) is listed in `.gitignore`
- [ ] `.env.example` exists and contains only placeholder values
- [ ] `git log` confirms `.env` was never committed

---

## Dependencies

- [ ] `pip-audit` / `npm audit` — no CRITICAL severity CVEs
- [ ] `pip-audit` / `npm audit` — no HIGH severity CVEs
- [ ] No dependency with last release > 2 years ago
- [ ] All dependency versions are pinned (no `>=` or `^` in production deps)

---

## Injection (OWASP A03)

- [ ] All database queries use parameterised statements or an ORM
- [ ] No f-string or string-concatenation SQL
- [ ] No `eval()` on user-supplied data
- [ ] No `exec()` on user-supplied data
- [ ] No `subprocess` call with `shell=True` and user-supplied arguments
- [ ] All file paths from user input are validated against an allowlist or sandboxed

---

## Authentication and session management (OWASP A07)

- [ ] Passwords are hashed with bcrypt, argon2, or scrypt (never MD5 or SHA1)
- [ ] JWTs do not accept `alg: none`
- [ ] Sessions expire after a reasonable period of inactivity
- [ ] Session tokens are not stored in localStorage (prefer httpOnly cookies)
- [ ] Logout invalidates the server-side session

---

## Sensitive data exposure (OWASP A02)

- [ ] No PII (names, emails, card numbers) written to log files
- [ ] No transaction amounts or financial data written to log files at DEBUG level
- [ ] HTTPS is enforced in production configuration
- [ ] Sensitive fields are not returned in API responses when not needed

---

## Security misconfiguration (OWASP A05)

- [ ] Debug mode is `False` / disabled in production configuration
- [ ] CORS is not set to wildcard (`*`) in production
- [ ] Error responses do not expose stack traces or internal file paths
- [ ] Default credentials changed (database, admin panels, etc.)
- [ ] Unnecessary features, endpoints, or services are disabled

---

## Cross-site scripting — XSS (OWASP A03)

- [ ] All user-supplied content is escaped before being rendered in HTML
- [ ] No `dangerouslySetInnerHTML` / `v-html` with untrusted data
- [ ] `Content-Security-Policy` header is set
- [ ] Jinja2 / template engine autoescaping is enabled

---

## Access control (OWASP A01)

- [ ] Every authenticated endpoint checks the caller's authorisation
- [ ] Object IDs from user input are validated against the caller's permissions
- [ ] Admin-only routes are protected by a role check, not just authentication

---

## Logging and monitoring (OWASP A09)

- [ ] Authentication events (login, logout, failure) are logged
- [ ] High-value actions (data export, permission change, delete) are logged
- [ ] Log entries include a timestamp and user identifier
- [ ] Logs do not contain sensitive data (passwords, tokens, full card numbers)
