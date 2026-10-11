#!/bin/bash
# Copia context-mode desde el repo oficial, sin la carpeta bin/ (claude.ai rechaza plugins con bin/ en la raíz).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"
git clone --depth 1 https://github.com/mksglu/context-mode "$TMP/up"
DEST="$ROOT/plugins/context-mode"
rm -rf "$DEST" && mkdir -p "$DEST"
tar -C "$TMP/up" --exclude=.git --exclude=bin --exclude=tests -cf - . | tar -C "$DEST" -xf -
rm -f "$DEST/.claude-plugin/marketplace.json" "$DEST/.gitignore" "$DEST/.npmignore"
VER="$(jq -r .version "$DEST/.claude-plugin/plugin.json")"
rm -rf "$TMP"
echo "Sincronizado context-mode v$VER"
