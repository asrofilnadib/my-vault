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

## Plugin Obsidian vs Quartz

Plugin Obsidian (Tasks, Dataview, Homepage, Kanban, …) **tidak** di-install ke Quartz. Yang dipakai: entri `@quartz-community/*` di `quartz.config.yaml` + `npm install`.

| Obsidian | Quartz (repo ini) |
|----------|-------------------|
| Admonition / callout | `obsidian-flavored-markdown` |
| Wikilink, embed, checkbox, Mermaid | OFM (sudah) |
| Excalidraw | `obsidian-plugin-excalidraw` |
| Omnisearch | `search` |
| Graph | `graph` |
| Tag Wrangler / colored tags | `tag-page`, `tag-list`, `parseTags` |
| Bases | `bases-page` |
| Calendar / Periodic / Homepage | tidak ada di web |
| **Tasks** (` ```tasks `) | **tidak ada** — blok tetap kosong |
| **Dataview** | **tidak ada** |
| **Kanban** | hanya teks markdown, bukan board |

Maintenance: `npx quartz plugin install --from-config` (bukan `plugin add` URL repo vault).
