#!/usr/bin/env bash
# validate-kits.sh — Validates every kit under kits/ against schemas/kit.schema.json
#
# Requirements:
#   - node (for ajv-cli) OR python3 (for jsonschema)
#   Install ajv-cli:  npm install -g ajv-cli ajv-formats
#   Install jsonschema: pip3 install jsonschema

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCHEMA="$REPO_ROOT/schemas/kit.schema.json"
KITS_DIR="$REPO_ROOT/kits"
ERRORS=0

if [[ ! -d "$KITS_DIR" ]]; then
  echo "No kits/ directory found — nothing to validate."
  exit 0
fi

for kit_dir in "$KITS_DIR"/*/; do
  kit_name="$(basename "$kit_dir")"
  manifest="$kit_dir/kit.json"

  # Check required files exist
  for required in "kit.json" "README.md" "architecture.md" "workflows.md"; do
    if [[ ! -f "$kit_dir/$required" ]]; then
      echo "ERROR [$kit_name]: Missing required file: $required"
      ERRORS=$((ERRORS + 1))
    fi
  done

  # Validate kit.json against schema (prefer ajv-cli, fall back to python jsonschema)
  if [[ -f "$manifest" ]]; then
    if command -v ajv &>/dev/null; then
      if ! ajv validate -s "$SCHEMA" -d "$manifest" --spec=draft7 2>/dev/null; then
        echo "ERROR [$kit_name]: kit.json failed schema validation."
        ERRORS=$((ERRORS + 1))
      else
        echo "  OK [$kit_name]: kit.json is valid."
      fi
    elif command -v python3 &>/dev/null && python3 -c "import jsonschema" &>/dev/null; then
      if ! python3 -c "
import json, jsonschema, sys
schema = json.load(open('$SCHEMA'))
inst   = json.load(open('$manifest'))
jsonschema.validate(inst, schema)
" 2>/dev/null; then
        echo "ERROR [$kit_name]: kit.json failed schema validation."
        ERRORS=$((ERRORS + 1))
      else
        echo "  OK [$kit_name]: kit.json is valid."
      fi
    else
      echo "WARN [$kit_name]: No validator found (install ajv-cli or python3 jsonschema). Skipping schema check."
    fi
  fi
done

if [[ $ERRORS -gt 0 ]]; then
  echo ""
  echo "Validation failed with $ERRORS error(s)."
  exit 1
else
  echo ""
  echo "All kits passed validation."
fi
