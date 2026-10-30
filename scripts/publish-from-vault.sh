#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

bash "$ROOT/scripts/sync-vault-to-content.sh"
npx quartz build
npx quartz sync
bash "$ROOT/scripts/link-content-to-vault.sh"

echo "Push sent. Wait for GitHub Actions deploy on branch v5."
