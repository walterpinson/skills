# Contributing

## Adding a Standalone Artifact

### Skill
1. Create `skills/<skill-name>/SKILL.md` following the [authoring guide](./docs/authoring-skills.md).
2. The folder name must match the `name` field in the SKILL.md frontmatter.
3. Add a row to the **Skills** table in the root `README.md`.

### Agent
1. Create `agents/<name>.agent.md` following the [authoring guide](./docs/authoring-agents.md).
2. Add a row to the **Agents** table in the root `README.md`.

### Instruction
1. Create `instructions/<name>.instructions.md` following the [authoring guide](./docs/authoring-instructions.md).
2. Add a row to the **Instructions** table in the root `README.md`.

### Prompt
1. Create `prompts/<name>.prompt.md` following the [authoring guide](./docs/authoring-prompts.md).
2. Add a row to the **Prompts** table in the root `README.md`.

---

## Adding a Skill Kit

1. Create `kits/<kit-name>/` following the [kit authoring guide](./docs/authoring-kits.md).
2. Every kit **must** contain all four required files at the kit root:
   - `README.md` — usage details
   - `kit.json` — manifest; must include `$schema` pointing to `schemas/kit.schema.json`
   - `architecture.md` — Mermaid diagram of artifact relationships
   - `workflows.md` — Mermaid diagram of process flows
3. Internal artifact folders mirror the top-level layout:
   - `skills/<skill-name>/SKILL.md`
   - `agents/*.agent.md`
   - `instructions/*.instructions.md`
   - `prompts/*.prompt.md`
4. Add a row to the **Skill Kits** table in the root `README.md`.

---

## Conventions

| Convention | Rule |
|-----------|------|
| `namespace` in `kit.json` | No trailing dash — tooling appends it when constructing the full name |
| `requires` / `conflicts` | npm-style semver strings: `"namespace-kit-name@^1.0.0"` |
| `status` | `preview` while drafting; promote to `stable` after validation |
| `entryPrompt` | Path relative to the kit root; single string for v1 |
| Artifact duplication | Kits duplicate artifacts; no cross-references between kits and standalone folders in v1 |
| Folder categorization | Keep flat until any top-level artifact folder exceeds ~15 entries |

---

## Validation

Run the kit validator before submitting:

```bash
bash scripts/validate-kits.sh
```

This checks that every folder under `kits/` contains a valid `kit.json` conforming to `schemas/kit.schema.json`.
