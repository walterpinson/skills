# Example Kit

A reference kit demonstrating the required structure and conventions for skill kits in this library.

## Purpose

Use this kit as a starting point when authoring a new skill kit. It shows:

- The four required files at the kit root (`README.md`, `kit.json`, `architecture.md`, `workflows.md`)
- One example of each artifact type (`skills/`, `agents/`, `instructions/`, `prompts/`)
- A `kit.json` manifest that validates against `schemas/kit.schema.json`
- An orchestration prompt (`prompts/orchestrate.prompt.md`) as the recommended entry point

## Usage

1. Invoke the orchestration prompt in GitHub Copilot chat:
   ```
   /orchestrate
   ```
2. Follow the workflow steps surfaced by the orchestration prompt.
3. Any individual artifact (skill, agent, instruction, prompt) can also be invoked independently.

## Installation

Copy the contents of this kit into your project's `.github/` folder, preserving the subfolder layout:

```
.github/
├── agents/example.agent.md
├── instructions/example.instructions.md
├── prompts/orchestrate.prompt.md
└── skills/example-skill/SKILL.md
```

## Contents

| Artifact | Path | Description |
|----------|------|-------------|
| Skill | `skills/example-skill/SKILL.md` | Reference skill template |
| Agent | `agents/example.agent.md` | Reference agent template |
| Instruction | `instructions/example.instructions.md` | Reference instruction template |
| Orchestration Prompt | `prompts/orchestrate.prompt.md` | Entry point — start here |

## Authoring Notes

- See [`architecture.md`](./architecture.md) for the artifact relationship diagram.
- See [`workflows.md`](./workflows.md) for the process flow diagram.
- See [`kit.json`](./kit.json) for the manifest and schema reference.
- See the root [`CONTRIBUTING.md`](../../CONTRIBUTING.md) for kit authoring conventions.
