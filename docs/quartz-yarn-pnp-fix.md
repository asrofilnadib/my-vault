# Quartz build — Yarn PnP conflict (fixed)

## Symptom

`npx quartz build --serve` fails with:

- `Could not resolve "micromorph"`
- `The Yarn Plug'n'Play manifest forbids importing ...`
- Reference to `../../../.pnp.cjs`

## Cause

An **orphaned** Yarn PnP file lived at `~/.pnp.cjs` (workspace `asrofil`) **without** a matching `~/package.json`. Esbuild walks up from `my-notes` and uses that manifest, so npm `node_modules` in this repo are ignored.

## Fix applied

1. Renamed `~/.pnp.cjs` → `~/.pnp.cjs.bak-orphan-yarn` (backup, not deleted).
2. Moved `@quartz-community/utils` to `dependencies` in `package.json` (needed when bundling inline scripts).

## Run locally

```bash
cd ~/Project/personal/my-notes
npx quartz build --serve
```

Open http://localhost:8080

## If you use Yarn Berry at home again

Restore a proper `~/package.json` + `.pnp.cjs` pair, **or** keep Quartz builds outside `~/` / disable PnP for npm-only projects. Do not leave a lone `.pnp.cjs` in `$HOME`.
