#Tech #ani-cli #Terminal #Anime

> CLI buat **browse + nonton anime** dari terminal. Search judul → pilih dari `fzf` → pilih episode → diputar di **mpv**.
>
> Repo: [pystardust/ani-cli](https://github.com/pystardust/ani-cli)
> Skip OP/ED: [synacktraa/ani-skip](https://github.com/synacktraa/ani-skip) (dipanggil lewat flag `--skip`, jangan dijalankan sendiri pas nonton)
>
> Bantuan cepat di terminal: `ani-cli -h`

# Table of contents
- [[#Alur dasar (yang paling sering)]]
- [[#Cheatsheet perintah]]
- [[#ani-skip (auto skip OP/ED)]]
- [[#Kontrol mpv]]
- [[#Subtitle (Indo / English)]]
- [[#History & continue]]
- [[#Download]]
- [[#Config / environment]]
- [[#Troubleshooting]]
- [[#Install curl-impersonate]]
- [[#Contoh konkret]]

---

## Alur dasar (yang paling sering)

Nonton + skip intro (pola harian):

```bash
ani-cli --skip "chainsmoker cat"
```

Yang terjadi:

1. Ketik / pass query judul → Enter
2. Pilih judul dari daftar `fzf` (panah + Enter)
3. Pilih episode
4. Video dibuka di **mpv**
5. Setelah mpv ditutup (`q`), balik ke menu ani-cli (next ep, replay, search lagi, quit)

Kalau judul nggak ketemu, coba alias / judul Jepang:

```bash
ani-cli --skip "yani neko"
ani-cli --skip "ヤニねこ"
```

> Chainsmoker Cat = **ヤニねこ** / **Yani Neko**. Sumber scraping kadang pakai nama Inggris, kadang Jepang.

---

## Cheatsheet perintah

| Mau apa | Perintah | Keterangan |
|---------|----------|------------|
| Nonton (search) | `ani-cli "judul"` | Pilih judul + episode di fzf |
| Nonton + skip OP/ED | `ani-cli --skip "judul"` | **Paling sering.** Butuh mpv + ani-skip |
| Episode spesifik | `ani-cli --skip -e 3 "judul"` | Langsung ep 3 |
| Range episode | `ani-cli -e 5-8 "judul"` | Ep 5 sampai 8 |
| Beberapa episode | `ani-cli -e "5 6 7" "judul"` | Ep 5, 6, 7 |
| Lanjut nonton | `ani-cli -c` | Dari history episode terakhir |
| Dub | `ani-cli --skip --dub "judul"` | Kalau sumbernya ada dub |
| Kualitas | `ani-cli -q 1080p "judul"` | `720p`, `1080p`, `best`, `worst` |
| Download 1 ep | `ani-cli -d -e 2 "judul"` | File masuk cwd (folder saat ini) |
| Download banyak | `ani-cli -d -e 1-12 "judul"` | Bulk download |
| Pakai VLC | `ani-cli --vlc "judul"` | `--skip` **tidak** jalan di VLC |
| Hapus history | `ani-cli -D` | Clear history nonton |
| Update ani-cli | `sudo ani-cli -U` | Linux |
| Bantuan | `ani-cli -h` | Semua flag |
| Versi | `ani-cli -V` | Cek versi |

Flag pendek yang sering kebaca:

| Flag | Alias | Artinya |
|------|-------|---------|
| `-c` | `--continue` | Lanjut dari history |
| `-d` | `--download` | Download, jangan play |
| `-D` | `--delete` | Hapus history |
| `-e` | `--episode` / `--range` | Nomor / range episode |
| `-q` | `--quality` | Resolusi |
| `-S` | `--select-nth` | Pilih hasil search ke-N (skip fzf) |
| `-v` | `--vlc` | Player VLC |
| `--skip` | | Aktifkan ani-skip (mpv only) |
| `--dub` | | Versi dub |
| `--no-detach` | | mpv nempel di terminal (berguna kalau playback in-terminal) |
| `-N` | `--nextep-countdown` | Countdown episode berikutnya |
| `-U` | `--update` | Update script |

Contoh gabungan flag (urutan bebas):

```bash
ani-cli --skip -q 1080p -e 1 "chainsmoker cat"
ani-cli --skip -S 1 "one piece"          # langsung ambil hasil search pertama
ani-cli --vlc cyberpunk edgerunners -q 1080p -e 4
ani-cli blue lock -e 5-6
```

---

## ani-skip (auto skip OP/ED)

**Jangan** jalankan `ani-skip` di terminal pas mau nonton. `ani-cli` yang manggil.

Syarat:

- Player **mpv** (bukan VLC)
- `ani-skip` ada di PATH
- Data skip ada di [aniskip API](https://api.aniskip.com) — anime baru bisa **belum** ada timestamp-nya

### Pakai sekali-sekali

```bash
ani-cli --skip "chainsmoker cat"
```

### Pakai selalu (biar nggak ngetik `--skip`)

Tambah di `~/.zshrc`:

```bash
export ANI_CLI_SKIP_INTRO=1
```

Lalu `source ~/.zshrc`. Setelah itu cukup:

```bash
ani-cli "chainsmoker cat"
```

### Perilaku skip

- OP dan ED dilewati **sekali**. Seek mundur di mpv kalau mau nonton ulang.
- `--toggle` di ani-skip: tombol `T` (shift+t) di mpv buat nyala/mati skip terus-menerus. ani-cli biasanya cukup `--skip` default.
- Kalau tidak skip: bukan instalasi rusak. Episode itu belum ada di database aniskip.

### Tes ani-skip sendiri (opsional, debugging)

```bash
ani-skip -h
ani-skip -q "Chainsmoker Cat" -e 1
```

Kalau sukses, keluar opsi mpv kayak `--chapters-file=/tmp/... --script-opts=skip-op_start=...`. Kalau gagal / kosong, timestamp belum ada.

Update ani-skip:

```bash
sudo ani-skip -U
```

---

## Kontrol mpv

Yang sering dipake pas nonton:

| Tombol | Fungsi |
|--------|--------|
| `Space` | Pause / play |
| `←` / `→` | Mundur / maju ±5 detik |
| `↑` / `↓` | Volume |
| `f` | Fullscreen |
| `[` / `]` | Perlambat / percepat playback |
| `j` | Cycle subtitle (kalau ada track terpisah; di ani-cli sub sering **baked in**) |
| `9` / `0` | Volume kecil / besar |
| `q` | Keluar → balik ke menu ani-cli |

> Subtitle di ani-cli biasanya **nempel di video** (hardsub). Nggak bisa ganti bahasa / matiin lewat mpv.

---

## Subtitle (Indo / English)

ani-cli **tidak punya opsi pilih bahasa subtitle**. Yang di-stream dari anidb.app:

| Mode | Flag | Isi biasanya |
|------|------|----------------|
| Sub (default) | tidak perlu / `ANI_CLI_MODE=sub` | Audio Jepang. Sub English **kalau** encode-nya hardsub. Kadang raw (tanpa sub). |
| Dub | `--dub` | Audio Inggris. Sub Indo **tidak ada**. |

Tidak ada mode subtitle Indonesia. Kalau default-nya kosong / cuma Jepang:

```bash
# coba dub Inggris
ani-cli --skip --dub "chainsmoker cat"
```

Di mpv, tekan `j` / `J` buat cycle subtitle track. Kalau tidak berubah, artinya **tidak ada track terpisah** (hardsub atau memang tidak ada).

Kalau sudah punya file `.srt` sendiri:

```bash
# sekali nonton, lewat extra flags mpv
ANI_CLI_PLAYER_FLAGS="--sub-file=/path/ke/episode1.srt" ani-cli --skip -e 1 "chainsmoker cat"
```

Atau setelah mpv kebuka, drag file `.srt` ke window mpv / `sub-add` lewat console.

---

## History & continue

ani-cli nyimpen episode terakhir yang ditonton.

```bash
ani-cli -c          # lanjut dari history
ani-cli -D          # hapus semua history
```

Pakai `-c` kalau kemarin nonton ep 4, besok tinggal lanjut tanpa search ulang.

---

## Download

```bash
# 1 episode, folder saat ini
ani-cli -d -e 2 "chainsmoker cat"

# season / banyak episode
ani-cli -d -e 1-12 "chainsmoker cat"
```

File masuk **working directory** (folder tempat perintah dijalankan), kecuali env ini di-set:

```bash
export ANI_CLI_DOWNLOAD_DIR="$HOME/Videos/Anime"
```

Butuh `yt-dlp` (utama) atau `ffmpeg` (fallback).

---

## Config / environment

Bisa ditaruh di `~/.zshrc`:

| Variable | Isi | Kegunaan |
|----------|-----|----------|
| `ANI_CLI_SKIP_INTRO` | `1` / `0` | Auto `--skip` |
| `ANI_CLI_PLAYER` | `mpv` / `vlc` | Ganti player default |
| `ANI_CLI_DOWNLOAD_DIR` | path | Folder download |
| `ANI_CLI_QUALITY` | `1080p` dll | Kualitas default |
| `ANI_SKIP_TOGGLE_KEY` | mis. `T` | Keybind toggle skip di mpv |

Contoh blok siap tempel:

```bash
export ANI_CLI_SKIP_INTRO=1
export ANI_CLI_DOWNLOAD_DIR="$HOME/Videos/Anime"
```

---

## Troubleshooting

| Gejala | Yang dicoba |
|--------|-------------|
| `Unable to locate package` pas install `.deb` | Bukan ani-cli. `apt` butuh path: `sudo apt install ./file.deb` |
| Search kosong / judul nggak ada | Coba judul Inggris, Jepang, atau potongan kata (`yani`, `neko`) |
| `No results found` di **semua** judul + versi lama (`4.x`) | AllAnime sudah mati. Update ke **v5**: `sudo ani-cli -U` lalu `ani-cli -V` harus `5.0.x` |
| `Blocked by cloudflare` | Provider v5 (anidb) kena CF. Butuh **curl-impersonate**, bukan `curl` biasa. Lihat [[#Install curl-impersonate]] |
| `zsh: command not found: curl-impersonate` | Normal. Binary-nya **bukan** `curl-impersonate`. Yang dicari ani-cli: `curl_firefox135` / `curl_chrome136` / `curl_chrome116` / `curl_ff117` |
| `invalid color specification: search:#e5c07b` + `Invalid episode selection` | fzf Debian 0.44.1 tidak kenal color key `search:`. Di `~/.zshrc` ganti jadi `query:#e5c07b`, lalu `source ~/.zshrc`. Alur pilih judul + episode baru muncul. |
| `--skip` tidak skip | Anime/episode belum di aniskip API; atau player-nya VLC |
| Skip error / ani-skip tidak ketemu | Cek `which ani-skip` dan `which mpv` |
| Video nggak play | Pastikan `mpv` terinstall: `mpv --version` |
| Download gagal | Install/update `yt-dlp` |
| ani-cli aneh / pecah | Update dulu: `sudo ani-cli -U` |

### Install curl-impersonate

ani-cli 5.0.3 cek binary ini berurutan, fallback ke `curl` biasa kalau tidak ada:

`curl_firefox135` → `curl_chrome136` → `curl_chrome116` → `curl_ff117` → `curl`

Kalau yang kepakai `curl`, Cloudflare balas halaman "Just a moment" → `Blocked by cloudflare` → search kosong.

**Cara yang disarankan (fork terbaru, cocok v5):**

```bash
sudo apt install -y ca-certificates libnss3 nss-plugin-pem

cd /tmp
curl -LO "https://github.com/lexiforest/curl-impersonate/releases/download/v2.1.1/curl-impersonate-v2.1.1.x86_64-linux-gnu.tar.gz"
sudo tar xf curl-impersonate-v2.1.1.x86_64-linux-gnu.tar.gz -C /usr/local/bin
```

Cek sudah ketemu:

```bash
command -v curl_chrome136
command -v curl_firefox135
```

Harus keluar path, misalnya `/usr/local/bin/curl_chrome136`. Baru:

```bash
ani-cli --skip "chainsmoker cat"
```

**Fallback README resmi (lebih lama, tetap masuk daftar failover):**

```bash
curl -LO "https://github.com/lwthiker/curl-impersonate/releases/download/v0.6.1/curl-impersonate-v0.6.1.x86_64-linux-gnu.tar.gz"
sudo tar xf curl-impersonate-v0.6.1.x86_64-linux-gnu.tar.gz -C /usr/local/bin
```

Yang ini nyediain `curl_chrome116` / `curl_ff117`.

Dependency inti: `grep`, `sed`, `curl` (atau curl-impersonate), `mpv`, `fzf`, `yt-dlp`/`ffmpeg`, `patch` (buat `-U`), `ani-skip` (opsional).

---

## Contoh konkret

### Chainsmoker Cat — nonton ep 1 + skip

```bash
ani-cli --skip -e 1 "chainsmoker cat"
```

Kalau fzf muncul lebih dari 1 hasil, panah ke yang paling pas lalu Enter.

### Chainsmoker Cat — lanjut kemarin

```bash
ani-cli -c
```

(`--skip` tetap perlu kalau `ANI_CLI_SKIP_INTRO` belum di-set.)

```bash
ani-cli --skip -c
```

### One Piece — hasil ke-2 di search, skip intro

```bash
ani-cli --skip -S 2 "one piece"
```

### Cyberpunk Edgerunners — download ep 2

```bash
cd ~/Videos/Anime
ani-cli -d -e 2 "cyberpunk edgerunners"
```

### Dub + 1080p

```bash
ani-cli --skip --dub -q 1080p "chainsmoker cat"
```

---

## FAQ singkat (biar nggak bingung pas buka catatan)

- **Ganti bahasa subtitle?** Tidak dari ani-cli. Default = audio Jepang ± hardsub. `--dub` = audio Inggris. Sub Indo tidak tersedia. File `.srt` sendiri: `ANI_CLI_PLAYER_FLAGS="--sub-file=..."`.
- **Nonton dub?** Ya, `--dub`. Bahasa dub tidak bisa diganti.
- **Harus `-e 1` dulu?** Tidak. Default-nya interactive: search → pilih judul (fzf) → pilih episode (fzf). `-e` cuma shortcut. Kalau fzf error warna, picker-nya gagal dan kelihatan seperti "wajib -e".
- **Ganti sumber streaming?** Tidak (kecuali scrape sendiri).
- **ani-skip di Windows?** Praktis tidak jalan. Di Linux + mpv oke.
- **Jalankan `ani-skip` dulu baru `ani-cli`?** Tidak perlu. Cukup `--skip` atau `ANI_CLI_SKIP_INTRO=1`.
