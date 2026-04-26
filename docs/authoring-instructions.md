# Authoring Instructions

## Overview
Instruction files provide guidelines loaded on-demand when relevant to the current task, or automatically when files match a pattern.

## File Location
```
instructions/<name>.instructions.md
```

## Frontmatter

```yaml
---
description: "<required>"    # For on-demand discovery — keyword-rich; use "Use when..." pattern
name: "Instruction Name"     # Optional, defaults to filename
applyTo: "**/*.ts"           # Optional: auto-attach when matching files are in context
---
```

### Discovery Modes

| Mode | Trigger | When to Use |
|------|---------|-------------|
| On-demand (`description`) | Agent detects task relevance | Task-based: migrations, API work |
| Explicit (`applyTo`) | Matching files in context | File-based: language standards |

## Body Guidelines

- One concern per file — don't mix testing + styling + API design.
- Be concise; instruction files share the context window.
- Prefer brief code examples over lengthy prose.
- Use `applyTo: "**"` only when guidelines apply to every file type (use with caution).

## Checklist

- [ ] `description` uses "Use when..." pattern with trigger keywords
- [ ] `applyTo` pattern is as specific as possible
- [ ] File is focused on a single concern
- [ ] Row added to root `README.md` Instructions table
