#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VAULT="${VAULT_PATH:-/home/asrofil/Obsidian/Asrofil Vault}"
CONTENT="$ROOT/content"
EXCLUDES="$ROOT/scripts/publish-excludes.txt"

if [[ ! -d "$VAULT" ]]; then
  echo "Vault not found: $VAULT"
  exit 1
fi

if [[ ! -f "$EXCLUDES" ]]; then
  echo "Missing $EXCLUDES"
  exit 1
fi

if [[ -L "$CONTENT" ]]; then
  rm "$CONTENT"
elif [[ ! -d "$CONTENT" ]]; then
  mkdir -p "$CONTENT"
fi

echo "Syncing vault → content/ (see publish-excludes.txt)"
rsync -a --delete \
  --exclude-from="$EXCLUDES" \
  --exclude '.obsidian/' \
  --exclude '.git/' \
  --exclude '.cursor/' \
  --exclude '.quartz-cache/' \
  --exclude 'node_modules/' \
  "$VAULT/" "$CONTENT/"

if [[ -e "$CONTENT/Files/TOKEN.md" ]]; then
  echo "ERROR: Files/TOKEN.md must not be published. Check publish-excludes.txt"
  exit 1
fi

echo "Done. $(find "$CONTENT" -name '*.md' | wc -l) markdown files."
