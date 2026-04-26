# Plan: Skills Library Repository Structure

## TL;DR
Organize the repo into top-level folders by artifact type (`skills/`, `agents/`, `instructions/`, `prompts/`) for independently usable artifacts, plus a `kits/` folder where each kit is a self-contained subfolder with the four required files (README, kit.json, architecture.md, workflows.md) and its own internal artifact subfolders. Add `schemas/` for the kit.json schema and `docs/` for authoring guides.

## Proposed Structure

```
/
├── README.md                          # Library overview, index, usage
├── LICENSE
├── CONTRIBUTING.md                    # Authoring + PR guidelines
│
├── skills/                            # Independently usable agent skills
│   └── <skill-name>/
│       ├── SKILL.md
│       └── (supporting assets)
│
├── agents/                            # Independently usable agents (chatmodes)
│   └── <agent-name>.agent.md
│
├── instructions/                      # Independently usable instruction files
│   └── <name>.instructions.md
│
├── prompts/                           # Independently usable prompts
│   └── <name>.prompt.md
│
├── kits/                              # Self-contained skill kits
│   └── <kit-name>/
│       ├── README.md                  # REQUIRED — usage + details
│       ├── kit.json                   # REQUIRED — manifest/install metadata
│       ├── architecture.md            # REQUIRED — mermaid: artifact relationships
│       ├── workflows.md               # REQUIRED — mermaid: process flows
│       ├── skills/<skill-name>/SKILL.md
│       ├── agents/*.agent.md
│       ├── instructions/*.instructions.md
│       └── prompts/*.prompt.md        # orchestration prompt(s) live here
│
├── schemas/
│   └── kit.schema.json                # JSON Schema for kit.json validation
│
├── docs/
│   ├── authoring-skills.md
│   ├── authoring-agents.md
│   ├── authoring-instructions.md
│   ├── authoring-prompts.md
│   ├── authoring-kits.md
│   └── kit-manifest.md                # kit.json field reference
│
└── scripts/                           # Optional tooling (validation, install)
    └── validate-kits.*                # Lints kit.json against schema
```

## Rationale

- **Top-level by artifact type** mirrors how GitHub Copilot / VS Code customization is consumed (`.github/instructions/`, `.github/prompts/`, `chatmodes/`), making it easy for a future installer to copy individual artifacts into a target repo's `.github/` folder.
- **`kits/` as peer to artifact folders** keeps bundled units distinct from independently usable ones. Reusing the same internal layout (`skills/`, `agents/`, etc.) inside each kit makes installation logic uniform — the installer treats a kit as a mini-library.
- **Standard kit artifacts at kit root** (README, kit.json, architecture.md, workflows.md) makes discovery and validation trivial — a kit is "any folder under `kits/` containing a `kit.json`".
- **`schemas/kit.schema.json`** enables editor autocomplete via `$schema` in each `kit.json` and supports CI validation.
- **Multi-platform readiness**: file naming follows GitHub Copilot conventions (`*.instructions.md`, `*.prompt.md`, `SKILL.md`). Adding Claude Code support later means either dual-emitting from the same source or adding a sibling `claude/` subfolder per artifact — the structure doesn't need to change to accommodate it.

## Decisions / Assumptions

### Layout
- Independent artifacts and kit-bundled artifacts are kept separate (not symlinked/cross-referenced). If a kit needs a skill that also exists standalone, it gets its own copy.
- Markdown is the source of truth; no build step required for v1.
- Flat folders under each artifact type until any folder exceeds ~15 entries; introduce category subfolders then.

### `kit.json` Schema (v1)

```jsonc
{
  "$schema": "https://raw.githubusercontent.com/walterpinson/skills/main/schemas/kit.schema.json",

  // Identity
  "name": "somenamespace-kit-name",        // unique kit id (typically namespaced)
  "namespace": "somenamespace",            // vendor/owner prefix; NO trailing dash (tooling adds it)
  "version": "0.0.1",                      // semver
  "author": "walterpinson",
  "kind": "somecategory",                  // taxonomy bucket (e.g., "testing", "azure")
  "status": "preview",                     // preview | stable | deprecated
  "summary": "Short one-line description", // brief blurb
  "description": "Longer markdown blurb",  // optional long-form (README remains source of truth)
  "keywords": [],                          // discoverability/search

  // Targeting & Install
  "targets": ["copilot"],                  // platforms: copilot | claude-code (future)
  "scopes":  ["workspace", "user"],        // supported install destinations; installer prompts user when both listed

  // Orchestration
  "entryPrompt": "prompts/orchestrate.prompt.md", // RECOMMENDED starting prompt, not a gate; all prompts remain freely invokable. Single string for v1; may accept string|string[] later (non-breaking).

  // Contents (glob-based discovery)
  "files": {
    "agents":       ["agents/*.agent.md"],
    "skills":       ["skills/*/SKILL.md", "skills/*/template/**"],
    "prompts":      ["prompts/*.prompt.md"],
    "instructions": ["instructions/*.instructions.md"]
  },

  // Relationships
  "requires":  [],   // npm-style strings, e.g., "namespace-other-kit@^1.0.0"
  "conflicts": []    // npm-style strings; kits that cannot coexist
}
```

### Resolved design questions
- **`requires` / `conflicts` entry shape** → npm-style strings with semver ranges (`"namespace-name@^1.0.0"`).
- **`scopes` semantics** → "supports either; installer prompts user."
- **`entryPrompt`** → single string for v1; it is a *recommended starting point*, not an access control. For multi-workflow kits, the orchestration prompt should route the user to the right workflow rather than declaring multiple peer entries.

## Verification
1. Create one example kit under `kits/example-kit/` with all four required files to validate the layout end-to-end.
2. Author the `schemas/kit.schema.json` and reference it from the example `kit.json` via `$schema`; confirm VS Code shows autocomplete.
3. Add one example of each independent artifact type to confirm naming conventions render correctly when copied into a consuming repo's `.github/` folder.
4. Update root `README.md` with an index/table of available skills, kits, agents, instructions, and prompts.

## Further Considerations
1. **Kits reference vs. duplicate shared artifacts?** → **Duplicate for v1**; add `references: []` to `kit.json` later if needed.
2. **Versioning** → **Per-kit versions in `kit.json`**; standalone artifacts ride git history until demand emerges.
3. **Categorization** → **Flat folders for now**; introduce category subfolders once any folder exceeds ~15 entries.
