#!/bin/bash
# Copia la skill de Claude desde el repo oficial y actualiza la versión del plugin.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/Graphify-Labs/graphify.git "$TMP/up"
DEST="$ROOT/plugins/graphify/skills/graphify"
rm -rf "$DEST" && mkdir -p "$DEST"
cp "$TMP/up/graphify/skill.md" "$DEST/SKILL.md"
cp -r "$TMP/up/graphify/skills/claude/references" "$DEST/references"
VER="$(grep -m1 '^version' "$TMP/up/pyproject.toml" | cut -d'"' -f2)"
cat > "$ROOT/plugins/graphify/.claude-plugin/plugin.json" <<JSON
{
  "name": "graphify",
  "version": "$VER",
  "description": "Grafo de conocimiento de cualquier carpeta con /graphify (upstream: Graphify-Labs/graphify v$VER). Requiere: pip install graphifyy",
  "homepage": "https://github.com/Graphify-Labs/graphify",
  "license": "MIT"
}
JSON
cp "$TMP/up/LICENSE-MIT" "$ROOT/LICENSE-UPSTREAM" 2>/dev/null || cp "$TMP/up/LICENSE" "$ROOT/LICENSE-UPSTREAM"
rm -rf "$TMP"
echo "Sincronizado graphify v$VER"
