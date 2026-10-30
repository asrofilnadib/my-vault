#Tech #Tmux #CommandPrompting

Prefix lu **bukan** `Ctrl+b` default. Di `~/.tmux.conf` prefix diganti jadi **`Ctrl+a`**.

Di note ini: `prefix` = `Ctrl+a`.

---

## Mental Model

```
tmux server
  └── session   (main, catastrophy, work, armagedon, aquarium)
        └── window
              └── pane
```

- **Session** = workspace yang hidup meski terminal ditutup
- **Window** = tab di dalam session
- **Pane** = split di dalam window

---

## Session

```bash
# List session
tmux ls
tmux list-sessions

# Buat session baru (langsung masuk)
tmux new -s nama-session

# Buat session di background, belum attach
tmux new -s nama-session -d

# Attach
tmux attach -t nama-session
tmux a -t nama-session

# Attach session terakhir
tmux attach
tmux a

# Cek session ada atau tidak
tmux has-session -t main

# Rename session (dari luar)
tmux rename-session -t lama baru

# Detach (dari dalam tmux) — session tetap hidup
# prefix + d

# Kill satu session
tmux kill-session -t nama-session

# Kill semua session + server
tmux kill-server
```

Dari dalam tmux:

| Keys | Aksi |
|------|------|
| `prefix` `d` | Detach |
| `prefix` `s` | Pilih session (list interaktif) |
| `prefix` `$` | Rename session |
| `prefix` `(` / `)` | Session sebelumnya / berikutnya |

Setup lu: buka terminal lokal (bukan SSH) otomatis attach ke session **`main`**. Kalau `main` belum ada, `.bashrc` bikin layout 4 pane (`btop` kiri, `neofetch` kanan bawah, 2 pane kerja).

```bash
# Reset layout main dari nol
tmux kill-session -t main
# lalu buka terminal baru
```

---

## Window

| Keys | Aksi |
|------|------|
| `prefix` `c` | Window baru |
| `prefix` `n` / `p` | Window berikutnya / sebelumnya |
| `prefix` `0`–`9` | Lompat ke window by number |
| `prefix` `,` | Rename window |
| `prefix` `&` | Kill window (konfirmasi) |
| `prefix` `w` | List window |

```bash
# Dari luar
tmux new-window -t main -n logs
tmux rename-window -t main:0 backend
tmux kill-window -t main:logs
tmux list-windows -t main
```

---

## Pane — custom lu, bukan default tmux

Default tmux: `prefix` `x` = kill pane. **Di config lu itu di-unbind.**

`prefix` `x` = **split atas-bawah**. Close pane = `prefix` `q`.

### Split

| Keys | Aksi |
|------|------|
| `prefix` `v` | Split kiri-kanan 50-50 |
| `prefix` `x` | Split atas-bawah 50-50 |
| `prefix` `V` | Split kiri-kanan, pane baru 30% |
| `prefix` `X` | Split atas-bawah, pane baru 30% |
| `prefix` `Ctrl+v` | Split kiri-kanan, pane baru 40% |
| `prefix` `Ctrl+x` | Split atas-bawah, pane baru 40% |

Split ikut directory pane aktif (`#{pane_current_path}`).

```bash
# Dari command (bukan keybind)
tmux split-window -h          # kiri-kanan
tmux split-window -v          # atas-bawah
tmux split-window -h -p 30    # pane baru 30%
```

### Navigasi & resize

| Keys | Aksi |
|------|------|
| `prefix` `h` `j` `k` `l` | Pindah pane (vim) |
| klik mouse | Pilih pane |
| `prefix` `H` `J` `K` `L` | Resize 5 cell (bisa ditahan, `-r`) |
| `prefix` `=` | Layout tiled (rata) |
| `prefix` `z` | Zoom pane (fullscreen / balik) |
| `prefix` `{` / `}` | Tukar posisi pane |
| `prefix` `q` | **Kill pane** (tanpa konfirmasi) |
| `prefix` `!` | Pecah pane jadi window baru |

Mouse on: drag border pane buat resize.

---

## Copy / paste (config lu)

Mouse on + vi copy mode. Drag highlight → langsung ke clipboard via `xclip`.

| Keys | Aksi |
|------|------|
| drag mouse | Copy + keluar copy-mode |
| `prefix` `[` | Masuk copy-mode manual |
| `v` | Mulai seleksi (di copy-mode) |
| `C-v` | Rectangle select |
| `y` atau `Enter` | Copy ke clipboard, keluar mode |
| `prefix` `]` | Paste buffer tmux |

Di copy-mode navigasi vim: `h` `j` `k` `l`.

---

## Config & reload

File: `~/.tmux.conf`

| Keys | Aksi |
|------|------|
| `prefix` `r` | Reload `~/.tmux.conf` |
| `prefix` `R` | Jalankan preset layout `~/.tmux-preset-layout.sh` |

```bash
tmux source-file ~/.tmux.conf
```

`prefix` `R` (dari dalam tmux) reset window jadi:

- kiri ~40% → `btop`
- kanan split 50-50, fokus kanan atas

Status bar **mati** (`set -g status off`). List session/window pakai `prefix` `s` / `w` atau `tmux ls`.

Plugin: **tmux-resurrect** (`~/.tmux/plugins/tmux-resurrect`). Restore session setelah reboot:

| Keys (default plugin) | Aksi |
|------|------|
| `prefix` `Ctrl+s` | Save |
| `prefix` `Ctrl+r` | Restore |

---

## Layout & alias di mesin lu

| Alias / script | Session | Isi |
|----------------|---------|-----|
| auto `.bashrc` | `main` | 4 pane: `btop` kiri, kerja, `neofetch` |
| `catastrophy` | `catastrophy` | `~/.tmux-catastrophy.sh` — kill session lama, 4 pane, `btop` kiri lebar 100 |
| `armagedon` | `armagedon` | `~/.tmux-armagedon.sh` — 2 pane kiri-kanan |
| `aqua` | `aquarium` | `asciiquarium` |
| `~/.tmux-layouts.sh` | `work` | 4 pane + `htop` kiri bawah (auto-start ini **di-comment** di bashrc) |
| `~/.tmux-preset-layout.sh` | (window aktif) | `prefix` `R` — 3 pane + `btop` |

```bash
catastrophy
armagedon
aqua
```

`catastrophy` / `armagedon` / `~/.tmux-layouts.sh` **kill session namanya dulu** kalau sudah ada, lalu bikin ulang.

```bash
# Layout work manual (bashrc auto-nya lagi off)
bash ~/.tmux-layouts.sh
```

---

## Command cheatsheet

```bash
# Session
tmux ls
tmux new -s dev
tmux new -s dev -d
tmux a -t dev
tmux a
tmux kill-session -t dev
tmux kill-server
tmux rename-session -t main kerja

# Window
tmux new-window -n logs
tmux kill-window -t logs
tmux rename-window backend

# Pane
tmux split-window -h
tmux split-window -v
tmux kill-pane
tmux kill-pane -a              # bunuh semua pane kecuali yang aktif
tmux select-pane -t 1
tmux resize-pane -L 10
tmux resize-pane -R 10
tmux resize-pane -U 5
tmux resize-pane -D 5
tmux resize-pane -x 80         # set lebar
tmux resize-pane -y 26         # set tinggi

# Info
tmux list-panes
tmux list-windows
tmux display-message -p '#S'   # nama session aktif
tmux display-message -p '#P'   # index pane

# Kirim command ke pane lain
tmux send-keys -t main:0.0 'btop' C-m
```

---

## Prefix key cheatsheet (Ctrl+a)

| Keys | Aksi |
|------|------|
| `prefix` `d` | Detach |
| `prefix` `c` | Window baru |
| `prefix` `n` `p` | Next / prev window |
| `prefix` `,` | Rename window |
| `prefix` `&` | Kill window |
| `prefix` `v` | Split kiri-kanan |
| `prefix` `x` | Split atas-bawah (**bukan** kill) |
| `prefix` `q` | Kill pane |
| `prefix` `h` `j` `k` `l` | Pindah pane |
| `prefix` `H` `J` `K` `L` | Resize pane |
| `prefix` `=` | Tiled |
| `prefix` `z` | Zoom pane |
| `prefix` `[` | Copy mode |
| `prefix` `]` | Paste |
| `prefix` `r` | Reload conf |
| `prefix` `R` | Preset layout (btop kiri) |
| `prefix` `s` | List session |
| `prefix` `w` | List window |
| `prefix` `:` | Command prompt tmux |

Kirim `Ctrl+a` ke program di dalam pane (nano, dll): `prefix` lalu `Ctrl+a` lagi (`send-prefix`).

---

## Troubleshooting cepat

```bash
# Session zombie / layout kacau
tmux kill-session -t main
tmux kill-server

# Nested tmux (SSH ke mesin yang juga auto-tmux)
# bashrc lu skip auto-start kalau $SSH_TTY terisi
# prefix remote vs local: local = Ctrl+a

# Clipboard drag-select ga ke Ctrl+V
sudo apt install xclip
# Wayland:
sudo apt install wl-clipboard
```

Lihat juga:
- [[install tmux for ubuntu]]
- [[Tmux Layout Automation & Custom Startup via .bashrc]]
- [[support highlight copas tmux]]
