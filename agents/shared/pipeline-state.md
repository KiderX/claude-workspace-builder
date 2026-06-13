# Pipeline State Schema

This document defines the canonical context object the Orchestrator passes
from one agent to the next. Every agent reads from this state at the start
and appends its output to it when done.

---

## State object

```
Pipeline State
├── meta
│   ├── session_id          string   — unique ID for this pipeline run
│   ├── project_path        string   — absolute path to the project root
│   ├── project_name        string   — derived from folder name or pyproject.toml
│   ├── tier                string   — "quick" | "standard" | "full"
│   └── request_summary     string   — one-sentence restatement of the user's request
│
├── plan
│   ├── agents_selected     list     — ordered list of agent numbers to run
│   ├── agents_completed    list     — agents that have finished successfully
│   ├── current_agent       int      — agent number currently running (null if none)
│   └── confirmed_by_user   bool     — whether the user approved the plan
│
└── artifacts
    ├── research_summary    string   — output of Agent 01 (null if not run)
    ├── arch_spec           string   — output of Agent 02 (null if not run)
    ├── engineer_report     string   — output of Agent 03 (null if not run)
    ├── review_report       string   — output of Agent 04 (null if not run)
    ├── deps_report_1       string   — first Deps/Docs run, after Engineer (null if not run)
    ├── cleanup_report      string   — output of Agent 06 (null if not run)
    ├── deps_report_2       string   — second Deps/Docs run, after Cleanup (null if not run)
    ├── ui_report           string   — output of Agent 07 (null if not run)
    └── security_report     string   — output of Agent 08 (null if not run)
```

---

## How each agent uses state

| Agent | Reads | Writes |
|-------|-------|--------|
| 01 Research  | `meta.request_summary` | `artifacts.research_summary` |
| 02 Architect | `artifacts.research_summary` | `artifacts.arch_spec` |
| 03 Engineer  | `artifacts.arch_spec` | `artifacts.engineer_report` |
| 04 Reviewer  | `artifacts.engineer_report` | `artifacts.review_report` |
| 05 Deps/Docs (run 1) | `artifacts.engineer_report` | `artifacts.deps_report_1` |
| 06 Cleanup   | `artifacts.review_report` | `artifacts.cleanup_report` |
| 05 Deps/Docs (run 2) | `artifacts.cleanup_report` | `artifacts.deps_report_2` |
| 07 UI Polish | `artifacts.cleanup_report` | `artifacts.ui_report` |
| 08 Security  | all prior artifacts | `artifacts.security_report` |

---

## Gate check fields

After each agent, the Orchestrator records:

```
gate_results
├── [agent_number]
│   ├── passed        bool
│   ├── blockers      list[string]   — empty if passed
│   └── re_run_count  int            — how many times this agent was re-run
```

If `passed` is false and `re_run_count` >= 2, escalate to the user rather than
re-running again.

---

## Carrying state forward

When invoking each agent, the Orchestrator constructs a context block:

```
## Context from prior agents

### Request
[meta.request_summary]

### Prior outputs
[paste each non-null artifact in order, labelled by agent name]

### Your task
[the specific goal for this agent, derived from the agent's AGENT.md]
```

This is the handoff block. Never omit it. Never start an agent without it.
