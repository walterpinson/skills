# Authoring Skills

## Overview
A skill is a folder of instructions, scripts, and resources that an agent loads on-demand for a specialized task.

## Structure

```
skills/<skill-name>/
├── SKILL.md           # Required — must match the folder name in the `name` frontmatter field
├── scripts/           # Executable code referenced from SKILL.md
├── references/        # Additional docs loaded progressively
└── template/          # Boilerplate assets the skill emits
```

## SKILL.md Frontmatter

```yaml
---
name: skill-name              # Required: lowercase alphanumeric + hyphens; must match folder name
description: 'What and when to use. Keyword-rich. Max 1024 chars.'
argument-hint: 'Optional hint shown for slash invocation'
user-invocable: true          # Optional: show as slash command (default: true)
disable-model-invocation: false # Optional: prevent auto-loading (default: false)
---
```

## Body Guidelines

- State **when to use** the skill early.
- Include numbered **procedure** steps.
- Link to supporting assets using relative paths (`./scripts/foo.sh`).
- Keep under 500 lines; move detail into `references/` files.

## Checklist

- [ ] Folder name matches `name` frontmatter field
- [ ] `description` contains trigger keywords
- [ ] Procedure steps are numbered and actionable
- [ ] All file references use relative paths
- [ ] Row added to root `README.md` Skills table
