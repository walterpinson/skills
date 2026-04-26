# Kits

Self-contained packages of agents, skills, prompts, and instructions that drop into a workspace or a user-wide VS Code Copilot environment.

Each kit is designed to be used as a unit, typically initiated via an orchestration prompt, but all individual artifacts within a kit remain independently invokable.

---

## Naming Convention

```
<namespace>-<kit-name>.kit/
```

- **`<namespace>`** — the vendor or owner prefix (e.g., `walterpinson`). No trailing dash in `kit.json`; the hyphen between namespace and kit name serves as the delimiter.
- **`<kit-name>`** — a short, descriptive, lowercase hyphenated name for the kit (e.g., `code-review`).
- **`.kit` suffix** — distinguishes kit folders from other directories under `kits/`; a kit is any folder here whose name ends in `.kit` and contains a `kit.json`.

**Examples:**
- `walterpinson-code-review.kit/`
- `walterpinson-azure-deploy.kit/`

> **Note:** The `example-kit/` folder in this directory predates this convention and serves as the reference template. It will be renamed in a future cleanup.

---

## Available Kits

| Kit | Status | Summary |
|-----|--------|---------|
| [example-kit](./example-kit/) | preview | Reference example demonstrating kit structure and conventions |

---

## Kit Anatomy

Every kit folder follows this layout:

```
<namespace>-<kit-name>.kit/
    kit.json            # name, version, author, kind, status, targets, scopes, etc.
    README.md           # what the kit does, install instructions, etc.
    architecture.md     # Mermaid diagram of artifact relationships
    workflows.md        # Mermaid diagram of process flows
    install.sh          # macOS / Linux installer (planned)
    install.ps1         # Windows installer (planned)
    uninstall.sh        # planned
    uninstall.ps1       # planned
    agents/             # *.agent.md
    skills/             # <skill-name>/SKILL.md
    prompts/            # *.prompt.md
    instructions/       # *.instructions.md (only if applicable)
```

**Required at kit root:** `kit.json`, `README.md`, `architecture.md`, `workflows.md`  
**Planned at kit root:** `install.sh`, `install.ps1`, `uninstall.sh`, `uninstall.ps1`

---

## Install Scopes

A kit can be installed into one or both of the following scopes, as declared in `kit.json` under `scopes`:

| Scope | Destination | Effect |
|-------|-------------|--------|
| `workspace` | `.github/` in the target repo | Available only in that workspace |
| `user` | VS Code user profile folder | Available across all workspaces for that user |

When a `kit.json` declares both scopes, the installer prompts the user to choose.

---

## Manifest (kit.json)

Every kit must include a `kit.json` at its root. The file must reference the JSON Schema for editor autocomplete and CI validation:

```jsonc
{
  "$schema": "../../schemas/kit.schema.json",

  // Identity
  "name": "walterpinson-example-kit",   // <namespace>-<kit-name>; no trailing dash in namespace
  "namespace": "walterpinson",
  "version": "0.0.1",                   // semver
  "author": "walterpinson",
  "kind": "example",                    // taxonomy bucket: testing, azure, devops, etc.
  "status": "preview",                  // preview | stable | deprecated
  "summary": "Short one-line description (max 256 chars)",
  "description": "Optional longer Markdown description",
  "keywords": [],

  // Targeting & Install
  "targets": ["copilot"],               // copilot | claude-code (future)
  "scopes":  ["workspace", "user"],     // installer prompts user when both listed

  // Orchestration — recommended entry point, not a gate
  "entryPrompt": "prompts/orchestrate.prompt.md",

  // Contents — glob patterns relative to the kit root
  "files": {
    "agents":       ["agents/*.agent.md"],
    "skills":       ["skills/*/SKILL.md", "skills/*/template/**"],
    "prompts":      ["prompts/*.prompt.md"],
    "instructions": ["instructions/*.instructions.md"]
  },

  // Relationships — npm-style semver strings: "namespace-name@^1.0.0"
  "requires":  [],
  "conflicts": []
}
```

See [kit.json Field Reference](../docs/kit-manifest.md) for full field documentation.

---

## Installer Behavior

> **The installer is planned.** Until `install.sh` / `install.ps1` are available, copy the kit's artifact subfolders manually into the target `.github/` folder or user profile directory.

**Planned installer behavior:**

1. Read `kit.json` — validate against schema, resolve `requires` and check `conflicts`.
2. Prompt the user to select an install scope (`workspace` or `user`) if both are declared.
3. Copy artifacts to the appropriate destination.
4. If `requires` lists other kits, install them first (recursive).
5. If `conflicts` lists an already-installed kit, abort with a clear error.

---

## Coexistence Rules

- **`conflicts`**: Two kits that declare each other in `conflicts` cannot both be installed in the same scope. The installer aborts if a conflict is detected.
- **`requires`**: A kit that lists another kit in `requires` will trigger that kit's installation first. Semver ranges (`^`, `~`, exact) are supported.
- **Naming collisions**: The install approach and collision-prevention strategy are not yet decided. Until they are, use `conflicts` to flag kits with overlapping artifact names.

---

## Roadmap

| Item | Status |
|------|--------|
| `install.sh` — macOS / Linux installer | planned |
| `install.ps1` — Windows installer | planned |
| `uninstall.sh` / `uninstall.ps1` — uninstallers | planned |
| `scripts/validate-kits.sh` — CI schema validation | available |
| Claude Code target support (`"targets": ["claude-code"]`) | planned |
| Kit registry / index for discoverability | planned |
| `references` field in `kit.json` for shared artifact cross-linking | planned (post-v1) |
