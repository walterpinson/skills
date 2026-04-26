# Authoring Prompts

## Overview
Prompts are reusable task templates triggered on-demand in chat. Keep each prompt focused on a single, well-defined task.

## File Location
```
prompts/<name>.prompt.md
```

## Frontmatter

```yaml
---
description: "<recommended>"  # Improves discoverability; shown in slash command list
name: "Prompt Name"           # Optional, defaults to filename
argument-hint: "Task..."      # Optional: hint shown in chat input
agent: "agent"                # Optional: ask | agent | plan | <custom-agent-name>
model: "Claude Sonnet 4"      # Optional
tools: [search, web]          # Optional
---
```

## Body Guidelines

- State the task goal clearly in the opening lines.
- Include an example of the expected output format when quality depends on structure.
- Reference supporting files with Markdown links.
- Avoid multi-task prompts — one prompt = one task.

## Checklist

- [ ] `description` helps users understand when to use this prompt
- [ ] Body is focused on a single task
- [ ] Output format example included where needed
- [ ] Row added to root `README.md` Prompts table
