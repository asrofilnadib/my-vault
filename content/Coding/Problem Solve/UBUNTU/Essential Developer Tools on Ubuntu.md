#Tech #Ubuntu #DeveloperTools #Linux

# Table of contents
- [[#Introduction]]
- [[#Prerequisite Flatpak & Flathub]]
- [[#Flameshot]]
- [[#gThumb]]
- [[#JOPDF]]
- [[#Remmina VNC & Remote Desktop]]
- [[#OBS Studio]]
- [[#ZapZap]]
- [[#Cursor]]
- [[#TextSnatcher]]
- [[#JetBrains Toolbox & DataGrip]]
- [[#Bonus Tools]]
	- [[#kitty]]
	- [[#Postman]]
	- [[#draw.io]]
	- [[#btop]]
- [[#Quick Reference]]

## Introduction

Kumpulan **tools esensial** yang gw pake sehari-hari di Ubuntu buat development & produktivitas. Mulai dari screenshot cepat, OCR, remote desktop, sampai IDE/database client.

Referensi app grid di mesin gw:

![[IMG/app-grid-1.png]]
![[IMG/app-grid-2.png]]
![[IMG/app-grid-3.png]]
![[IMG/app-grid-4.png]]

---

## Prerequisite Flatpak & Flathub

Beberapa app di bawah ini diinstall via Flatpak. Kalau belum siap:

```bash
sudo apt update
sudo apt install flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

Setelah itu logout/login sekali biar integrasi GNOME-nya rapi.

---

## Flameshot

Screenshot tool yang paling worth it di Linux: area select, annotate, copy ke clipboard, save — semuanya cepat. Buat dokumentasi bug / note Obsidian ini sangat membantu.

```bash
sudo apt update
sudo apt install flameshot
```

Jalankan sekali, atau set shortcut sendiri di **Settings → Keyboard → Keyboard Shortcuts** (misalnya `Print` / `Ctrl+Shift+S`) ke:

```bash
flameshot gui
```

---

## gThumb

Image viewer + browser yang ringan. Cocok buat buka / crop / rename batch screenshot sebelum masuk ke note.

```bash
sudo apt install gthumb
```

---

## JOPDF

PDF editor gratis buat Linux: baca, edit, annotate, convert, compress. Cocok kalau sering urus dokumen kerja / laporan tanpa bergantung ke Adobe.

Download `.deb` dari situs resmi: [jopdf.com/download-center](https://www.jopdf.com/download-center/)

Lalu install:

```bash
cd ~/Downloads
sudo dpkg -i jopdf-linux-amd64_setup.deb
sudo apt -f install   # fix dependency kalau perlu
```

Update nanti: uninstall dulu (`sudo apt remove jopdf`), baru install `.deb` versi baru.

---

## Remmina VNC & Remote Desktop

Client remote desktop all-in-one (RDP, VNC, SSH, dll). Di app grid gw ada Remmina — ini yang paling praktis buat nyambung ke VM / server / mesin remote.

```bash
sudo apt install remmina remmina-plugin-vnc remmina-plugin-rdp
```

Alternatif viewer khusus VNC (juga sering kepake):

```bash
sudo apt install tigervnc-viewer
```

---

## OBS Studio

Recording layar, demo fitur, atau streaming. Berguna buat dokumentasi video / meeting recording lokal.

```bash
sudo apt install obs-studio
```

> Kalau butuh versi lebih baru, bisa pakai PPA resmi OBS atau Flatpak `com.obsproject.Studio`.

---

## ZapZap

Client WhatsApp desktop unofficial yang native di Linux (multi-account, tray, notifikasi). Lebih enak dari nebeng browser doang.

```bash
flatpak install flathub com.rtosta.zapzap
```

Jalankan:

```bash
flatpak run com.rtosta.zapzap
```

---

## Cursor

AI code editor (VS Code-based) yang jadi daily driver coding gw.

Cara paling simpel — download `.deb` dari [cursor.com](https://cursor.com), lalu:

```bash
cd ~/Downloads
sudo dpkg -i cursor_*.deb
sudo apt -f install
```

Atau via script install resmi (cek halaman download Cursor untuk command terkini). Setelah terinstall, update biasanya lewat app itu sendiri.

---

## TextSnatcher

OCR: drag / ambil area gambar → text langsung ke clipboard. Berguna banget buat nyalin error message dari screenshot / UI yang ga bisa di-select.

```bash
flatpak install flathub com.github.rajsolai.textsnatcher
```

Jalankan:

```bash
flatpak run com.github.rajsolai.textsnatcher
```

---

## JetBrains Toolbox & DataGrip

**JetBrains Toolbox** adalah manager buat semua JetBrains IDE. Dari sini lu install / update **DataGrip** (dan PhpStorm kalau perlu) tanpa ribet.

1. Download Toolbox dari [jetbrains.com/toolbox-app](https://www.jetbrains.com/toolbox-app/)
2. Extract & jalankan:

```bash
cd ~/Downloads
tar -xzf jetbrains-toolbox-*.tar.gz
cd jetbrains-toolbox-*/
./jetbrains-toolbox
```

3. Di Toolbox → cari **DataGrip** → Install.
4. Pin DataGrip / Toolbox ke dock biar cepat diakses.

> Login JetBrains account di Toolbox supaya license & sync settings jalan.

---

## Bonus Tools

### kitty

Terminal GPU-accelerated, cepat, bagus buat tiling / multi-window workflow.

```bash
sudo apt install kitty
```

### Postman

API client buat test endpoint (REST, dll).

```bash
sudo snap install postman
```

Alternatif Flatpak:

```bash
flatpak install flathub com.getpostman.Postman
```

### draw.io

Diagram / flowchart desktop (ERD, arsitektur, alur bisnis).

```bash
sudo snap install drawio
```

Alternatif Flatpak:

```bash
flatpak install flathub com.jgraph.drawio.desktop
```

### btop

Resource monitor modern (CPU, RAM, disk, network) — lebih enak dibaca daripada `top` klasik.

```bash
sudo apt install btop
```

Jalankan:

```bash
btop
```

---

## Quick Reference

| Tool | Method | Command utama |
|------|--------|----------------|
| Flameshot | apt | `sudo apt install flameshot` |
| gThumb | apt | `sudo apt install gthumb` |
| JOPDF | official `.deb` | `sudo dpkg -i jopdf-linux-amd64_setup.deb` |
| Remmina | apt | `sudo apt install remmina remmina-plugin-vnc remmina-plugin-rdp` |
| TigerVNC Viewer | apt | `sudo apt install tigervnc-viewer` |
| OBS Studio | apt | `sudo apt install obs-studio` |
| ZapZap | Flatpak | `flatpak install flathub com.rtosta.zapzap` |
| Cursor | official `.deb` | `sudo dpkg -i cursor_*.deb` |
| TextSnatcher | Flatpak | `flatpak install flathub com.github.rajsolai.textsnatcher` |
| JetBrains Toolbox | official tarball | `./jetbrains-toolbox` lalu install DataGrip dari UI |
| kitty | apt | `sudo apt install kitty` |
| Postman | snap | `sudo snap install postman` |
| draw.io | snap | `sudo snap install drawio` |
| btop | apt | `sudo apt install btop` |
