# Claude Agent System

A structured multi-agent pipeline for delivering complete, production-ready software projects.
Each agent has a single responsibility, defined inputs, and defined outputs.
The Orchestrator coordinates them in sequence.

---

## Pipeline overview

```
Research → Architect → Engineer → Reviewer → Deps/Docs → Cleanup → UI Polish → Security
```

| # | Agent | Trigger phrase | Owns |
|---|-------|---------------|------|
| — | [Orchestrator](../CLAUDE.md) | `run full pipeline` | Coordination, sequencing, gates |
| 1 | [Research](01-research/AGENT.md) | `run research` | Tech stack selection, source citations |
| 2 | [Architect](02-architect/AGENT.md) | `run architect` | Project spec, file structure, schema |
| 3 | [Engineer](03-engineer/AGENT.md) | `run engineer` | Implementation, tests, dependency pinning |
| 4 | [Reviewer](04-reviewer/AGENT.md) | `run reviewer` | Linting, type-check, test run, code review |
| 5 | [Deps/Docs](05-deps-docs/AGENT.md) | `run deps-docs` | Dependency audit, README sync |
| 6 | [Cleanup](06-cleanup/AGENT.md) | `run cleanup` | Dead code removal, hygiene |
| 7 | [UI Polish](07-ui-polish/AGENT.md) | `run ui-polish` | Accessibility, responsiveness, UX |
| 8 | [Security](08-security/AGENT.md) | `run security` | OWASP checks, secrets scan, CVE audit |

---

## Quick-start

```
# Run all agents in sequence on the current project
run full pipeline

# Run a single agent
run research: best way to handle background jobs in Python

# Check pipeline state
status

# Find out what runs next
what's next
```

---

## Rules that apply to every agent

- **Never commit:** `.env`, `__pycache__`, `node_modules`, `*.pyc`, `.DS_Store`
- **Always present:** `.gitignore`, `README.md`, `.env.example`
- **Python deps:** pin in `pyproject.toml` — no bare `name` without `==x.y.z`
- **JS deps:** pin in `package.json` — no `^` or `~` on production deps
- **No secrets in code** — ever
- **No debug mode in production**
- **No wildcard CORS in production**
- **When ambiguous:** ask before proceeding
- **When deviating from spec:** explain why before doing it
- **When blocked:** say so clearly with the reason and what is needed to unblock

---

## Folder structure

```
agents/
├── README.md                          ← this file
├── shared/
│   ├── global-rules.md                ← code quality, git, security rules (loaded by Engineer + Reviewer)
│   └── pipeline-state.md              ← canonical context schema passed between agents
├── 01-research/
│   ├── AGENT.md
│   └── templates/
│       └── research-summary.md
├── 02-architect/
│   ├── AGENT.md
│   └── templates/
│       └── spec-template.md
├── 03-engineer/
│   ├── AGENT.md
│   └── templates/
│       └── handoff-report.md
├── 04-reviewer/
│   ├── AGENT.md
│   └── checklists/
│       └── review-checklist.md
├── 05-deps-docs/
│   ├── AGENT.md
│   └── templates/
│       └── audit-report.md
├── 06-cleanup/
│   ├── AGENT.md
│   └── templates/
│       └── cleanup-report.md
├── 07-ui-polish/
│   ├── AGENT.md
│   └── checklists/
│       └── ui-checklist.md
└── 08-security/
    ├── AGENT.md
    └── checklists/
        └── security-checklist.md
```
