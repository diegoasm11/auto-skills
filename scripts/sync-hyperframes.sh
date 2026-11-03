#!/bin/bash
# Copia solo las skills de HeyGen HyperFrames (sin bin/ ni el resto del monorepo) y su versión.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 https://github.com/heygen-com/hyperframes.git "$TMP/up"
DEST="$ROOT/plugins/hyperframes"
rm -rf "$DEST" && mkdir -p "$DEST/.claude-plugin"
cp -r "$TMP/up/skills" "$DEST/skills"
rm -f "$DEST"/skills/*.mjs
find "$DEST" -name bin -type d -prune -exec rm -rf {} +
cp "$TMP/up/LICENSE" "$DEST/LICENSE"
VER="$(jq -r .version "$TMP/up/.claude-plugin/plugin.json")"
cat > "$DEST/.claude-plugin/plugin.json" <<JSON
{
  "name": "hyperframes",
  "version": "$VER",
  "description": "HyperFrames by HeyGen: escribe HTML, renderiza video (upstream: heygen-com/hyperframes v$VER). Requiere: npx hyperframes",
  "homepage": "https://hyperframes.heygen.com",
  "license": "Apache-2.0"
}
JSON
rm -rf "$TMP"
echo "Sincronizado hyperframes v$VER"
