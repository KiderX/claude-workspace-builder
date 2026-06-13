# Claude Dev Workspace

Personal developer workspace in a Docker container with a full multi-agent pipeline baked in.

**Includes:** Ubuntu 24.04, Python 3.13 (pyenv), Poetry, Node.js 24, Claude Code CLI, Git + SSH passthrough, 8-agent orchestration system.

---

## What's inside

The image ships a complete multi-agent pipeline at `/root/.claude/`:

```
~/.claude/
├── CLAUDE.md           ← Orchestrator — auto-loaded every session
└── agents/
    ├── 01-research/    ← Tech stack research + citations
    ├── 02-architect/   ← Project spec + file structure
    ├── 03-engineer/    ← Implementation + tests
    ├── 04-reviewer/    ← Lint, type-check, test run, code review
    ├── 05-deps-docs/   ← Dependency audit + README sync
    ├── 06-cleanup/     ← Dead code removal
    ├── 07-ui-polish/   ← Accessibility, responsiveness, UX
    ├── 08-security/    ← OWASP checks, secrets scan, CVE audit
    └── shared/         ← Global rules + pipeline state schema
```

Start a session and describe what you want to build — the orchestrator routes to the right agents automatically.

```
run full pipeline       → all agents in sequence
run research            → research only
run engineer            → implement only
status                  → what has been done, what is pending
```

---

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- SSH key added to your agent (`ssh-add ~/.ssh/id_ed25519`)

---

## Build

```cmd
docker build -t claude-dev-workspace .
```

Only needed once, or after editing the Dockerfile or any file under `agents/`.

---

## Run

```cmd
docker run --rm -it --name claude-dev-container claude-dev-workspace
```

---

## First time only — log in to Claude

Inside the container:

```sh
claude login
```

Opens a browser URL on your host. Complete login, paste the code back. Done — credentials persist across runs.

---

## Connect a second terminal

```cmd
docker ps
docker exec -it claude-dev-container bash
```

---

## SSH passthrough

The container uses your host SSH agent — your private keys never enter the container.

- **Windows:** start an SSH agent before running `docker run`
- **macOS/Linux:** works automatically if `ssh-agent` is running

Verify inside the container: `ssh -T git@github.com`

---

## Updating the agent system

Edit any file under `agents/` or `CLAUDE.md`, then rebuild the image:

```cmd
docker build -t claude-dev-workspace .
```

The agents are baked into the image at build time. Credentials and project files live outside (via the `/workspace` volume), so a rebuild does not affect your work.
