#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VAULT="${VAULT_PATH:-/home/asrofil/Obsidian/Asrofil Vault}"
CONTENT="$ROOT/content"

if [[ ! -d "$VAULT" ]]; then
  echo "Vault not found: $VAULT"
  exit 1
fi

if [[ -L "$CONTENT" ]]; then
  echo "Already symlinked → $VAULT"
  exit 0
fi

if [[ -d "$CONTENT" ]]; then
  rm -rf "$CONTENT"
fi

ln -s "$VAULT" "$CONTENT"
echo "Linked content → $VAULT"
