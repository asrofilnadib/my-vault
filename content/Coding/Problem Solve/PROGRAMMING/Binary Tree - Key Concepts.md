# Binary Tree — Key Concepts

Catatan dari materi binary tree (NeetCode / video binary tree). Ditulis pakai cara pikir sendiri; ada beberapa istilah yang dirapikan biar nggak misleading pas interview.

---

## 1. Node, root, dan anak kiri–kanan

Binary tree itu punya **node**. Node paling atas / awalan disebut **root** — basically ancestor dari semua node di tree itu (root = satu node khusus yang nggak punya parent).

Dari root (dan dari node manapun), turunan ngarah ke pointer **kiri** dan **kanan** — itu **descendant** lewat anak kiri / anak kanan. Jadi struktur dibagi **maksimal 2** cabang per node: left child sama right child.

Yang perlu diingat: **maksimal** dua anak, bukan wajib dua-duanya ada. Boleh cuma kiri, cuma kanan, atau dua-duanya kosong.

---

## 2. Nggak boleh cycle

Turunan kiri **nggak** bisa “nyambung” sembarang ke turunan kanan bikin **loop** — intinya tree **acyclic**: arahnya **parent → child** ke bawah, nggak balik ke ancestor.

Bukan literal “kiri forbidden ke kanan”, tapi **nggak ada path** yang muter balik ke node yang udah dilewati di atas (contoh di materi: panah dari leaf balik ke root = **Cycles** ❌).

---

## 3. Leaf (daun)

**Leaf** = node yang **nggak punya anak lagi** (kiri dan kanan kosong / `null`).

Bukan “tiap sisi kiri/kanan pasti punya dasar leaf” dalam arti langsung — node tengah bisa cuma punya **satu** anak; cabang tetap **nanti** berakhir di leaf kalau tree-nya finite. Yang jelas: leaf = ujung cabang, bukan node yang masih punya descendant.

---

## 4. Satu arah — beda sama doubly linked list

Nggak kayak doubly linked list yang node bisa saling konek (`prev` / `next`). Di binary tree, hubungan buat struktur tree itu **parent ke anak** (left / right) — **satu arah** turun, bukan graph bebas.

**Catatan:** **Binary tree** = struktur (max 2 anak). **Binary search tree (BST)** = binary tree **plus** aturan urut nilai (misalnya kiri ≤ parent ≤ kanan). Jangan campur definisi struktur sama aturan BST.

---

## 5. Semua node harus nyambung ke tree

Kita **nggak bisa** bilang itu satu binary tree kalau ada node yang **ngambang** / nggak reachable dari root. Satu tree = **connected**: dari root, semua node ke-cover lewat path parent–child.

---

## 6. Height dan depth

Dua istilah yang sering kecampur:

| Istilah | Arti (umum di interview) |
|--------|---------------------------|
| **Depth** node | Jarak **dari root ke node** itu (root depth 0) |
| **Height** node | Panjang path **terpanjang ke bawah** dari node itu sampai leaf |
| **Height** tree | Height **root** (seberapa “tinggi” tree) |

“Kedalaman cabang” bisa maksud depth node atau height subtree — pas ngomong, sebut jelas depth vs height biar nggak salah paham.

---

## Bonus (nambah biar lengkap)

- **Subtree** = satu node + semua descendant-nya.
- **Empty tree** = `root == null` / nggak ada node.
- **Internal node** = bukan leaf (masih punya minimal satu anak).

---

## Referensi visual

Root (contoh materi), leaf di ujung cabang, dan **no cycles** — lihat catatan / screenshot video *Binary Trees* (NeetCode 17).
