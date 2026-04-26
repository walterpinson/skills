# kit.json Field Reference

All paths in `files` and `entryPrompt` are relative to the kit root.

## Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | `string` | Unique kit identifier, typically `<namespace>-<kit-name>`. Lowercase alphanumeric and hyphens only. |
| `namespace` | `string` | Vendor/owner prefix. **No trailing dash** — tooling appends it when needed. |
| `version` | `string` | Semantic version (semver): `MAJOR.MINOR.PATCH`. |
| `author` | `string` | Author name or handle. |
| `kind` | `string` | Taxonomy category (e.g., `testing`, `azure`, `devops`). |
| `status` | `enum` | `preview` \| `stable` \| `deprecated`. |
| `summary` | `string` | Short one-line description (max 256 chars). |
| `targets` | `string[]` | Target platforms. Values: `copilot`, `claude-code`. |
| `scopes` | `string[]` | Supported install destinations. Values: `workspace`, `user`. When both listed, installer prompts the user. |
| `files` | `object` | Glob patterns (relative to kit root) by artifact type. See sub-fields below. |

## Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `$schema` | `string` | JSON Schema reference. Should always be `"../../schemas/kit.schema.json"`. Enables VS Code autocomplete. |
| `description` | `string` | Longer Markdown description. The `README.md` remains the authoritative source of truth. |
| `keywords` | `string[]` | Tags for discoverability and search. |
| `entryPrompt` | `string` | Relative path to the recommended starting prompt. A suggestion, not a gate — all prompts remain freely invokable. |
| `requires` | `string[]` | Kit dependencies as npm-style semver strings: `"namespace-name@^1.0.0"`. |
| `conflicts` | `string[]` | Kits that cannot coexist, as npm-style semver strings. |

## `files` Sub-fields (all optional)

| Sub-field | Type | Description |
|-----------|------|-------------|
| `files.agents` | `string[]` | Globs matching agent files (`*.agent.md`). |
| `files.skills` | `string[]` | Globs matching skill files (`SKILL.md` and supporting assets). |
| `files.prompts` | `string[]` | Globs matching prompt files (`*.prompt.md`). |
| `files.instructions` | `string[]` | Globs matching instruction files (`*.instructions.md`). |

## Example

```jsonc
{
  "$schema": "../../schemas/kit.schema.json",
  "name": "walterpinson-example-kit",
  "namespace": "walterpinson",
  "version": "0.1.0",
  "author": "walterpinson",
  "kind": "example",
  "status": "preview",
  "summary": "A short description of what this kit does.",
  "keywords": ["example", "template"],
  "targets": ["copilot"],
  "scopes": ["workspace"],
  "entryPrompt": "prompts/orchestrate.prompt.md",
  "files": {
    "agents":       ["agents/*.agent.md"],
    "skills":       ["skills/*/SKILL.md", "skills/*/template/**"],
    "prompts":      ["prompts/*.prompt.md"],
    "instructions": ["instructions/*.instructions.md"]
  },
  "requires":  [],
  "conflicts": []
}
```
