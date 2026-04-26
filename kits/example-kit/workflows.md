# Workflows

Process flows implemented by the **example-kit**.

## Workflow 1 — Primary Orchestration

```mermaid
flowchart TD
    A([User invokes /orchestrate]) --> B[Orchestration prompt runs]
    B --> C{Determine task}
    C -->|Task A| D[Agent executes with example-skill]
    C -->|Task B| E[Agent executes with instructions only]
    D --> F([Done])
    E --> F
```

## Notes

- The orchestration prompt (`prompts/orchestrate.prompt.md`) is the recommended entry point but not mandatory.
- Individual skills, agents, instructions, and prompts can be invoked independently.
