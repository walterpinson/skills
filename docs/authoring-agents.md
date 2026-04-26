# Authoring Agents

## Overview
An agent is a custom persona with specific tools, instructions, and behaviors. Use for orchestrated workflows with role-based tool restrictions.

## File Location
```
agents/<name>.agent.md
```

## Frontmatter

```yaml
---
description: "<required>"    # Keyword-rich; used for agent picker and subagent discovery
name: "Agent Name"           # Optional, defaults to filename
tools: [read, search]        # Optional: built-in aliases, MCP (<server>/*), extension tools
model: "Claude Sonnet 4"     # Optional
argument-hint: "Task..."     # Optional
user-invocable: true         # Optional (default: true)
disable-model-invocation: false  # Optional (default: false)
---
```

### Common Tool Aliases

| Alias | Purpose |
|-------|---------|
| `read` | Read file contents |
| `edit` | Edit files |
| `search` | Search files or text |
| `execute` | Run shell commands |
| `agent` | Invoke subagents |
| `web` | Fetch URLs |

## Body Guidelines

- State the agent's persona and clear purpose in the opening line.
- List constraints explicitly.
- Keep tool set minimal — only what the role requires.

## Checklist

- [ ] `description` contains "Use when..." trigger phrases
- [ ] Tool set is minimal for the intended role
- [ ] `user-invocable: false` set for subagents not meant for direct user invocation
- [ ] Row added to root `README.md` Agents table
