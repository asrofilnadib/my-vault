# Publish Asrofil Vault ke GitHub Pages

Vault Obsidian: `/home/asrofil/Obsidian/Asrofil Vault`  
Repo Quartz: `~/Project/personal/my-vault` (branch `v5`, domain `obsidian.asrofil.my.id`)

## Alur

1. **Dev lokal** — symlink vault ke `content/`:
   ```bash
   npm run vault:link
   npx quartz build --serve
   ```
2. **Publish** — rsync dengan exclude, build, push:
   ```bash
   npm run vault:publish
   ```
3. **Hanya sync tanpa push** — `npm run vault:sync`

Daftar exclude: `scripts/publish-excludes.txt` (sinkronkan dengan `ignorePatterns` di `quartz.config.yaml`).

**Home di web:** root `/` butuh `index.md` di vault (bisa `![[Home]]` saja). Tanpa itu GitHub Pages menampilkan `index.xml` (RSS).

## Repo

- Backup penuh: repo privat `Asrofil_Vault_Obsidian`
- Publik: `asrofilnadib/my-vault` — jangan commit `Files/`, `Work/`, token, atau `.env`

## Setelah push gagal (secret scanning)

Rotasi token yang pernah masuk commit, lalu `git reset --hard origin/v5` jika commit belum ter-push. Publish ulang dengan exclude aktif.
