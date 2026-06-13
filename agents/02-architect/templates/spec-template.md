# Architecture Spec — [Project Name]

**Date:** YYYY-MM-DD  
**Spec version:** 1.0  
**Based on Research summary:** [link or inline]

---

## File structure

```
project-root/
├── [file or folder]       ← [one-line purpose]
├── [file or folder]       ← [one-line purpose]
│   ├── [file]             ← [one-line purpose]
│   └── [file]             ← [one-line purpose]
└── ...
```

---

## Tech stack

| Package | Version | Role |
|---------|---------|------|
| ...     | x.y.z   | ...  |

---

## Data models

```python
# Example — replace with actual models
@dataclass
class ExampleModel:
    id: int
    name: str
    created_at: datetime
```

---

## API endpoints

| Method | Path | Request | Response | Auth | Notes |
|--------|------|---------|----------|------|-------|
| GET    | /... | —       | ...      | none | ...   |

---

## Environment variables

| Variable | Type | Default | Required | Description |
|----------|------|---------|----------|-------------|
| `VAR_NAME` | string | — | yes | [description] |

### .env.example

```dotenv
# [Project Name] — environment variables
# Copy this file to .env and fill in real values. Never commit .env.

VAR_NAME=your_value_here
```

---

## Architectural decisions

| Decision | Alternatives considered | Reason |
|----------|------------------------|--------|
| ...      | ...                    | ...    |

---

## Implementation risks

<!-- Flag any areas the Engineer should approach with extra care. -->

- [ ] [Risk]: [mitigation strategy]
