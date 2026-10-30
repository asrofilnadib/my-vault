![[Pasted image 20260923224600.png]]
### 1. Sync grup dari WhatsApp (device 0851)
```bash
curl -X POST https://api.fonnte.com/fetch-group \
  -H "Authorization: QdFDsLZsLDttNB7Puq4a"
```

### 2. Lihat daftar grup + Group ID
```bash
curl -X POST https://api.fonnte.com/get-whatsapp-group \
  -H "Authorization: QdFDsLZsLDttNB7Puq4a"
```


1. dibuat agar task yang di assign oleh pengirim tidak bisa di edit oleh si penerima![[Pasted image 20260924193255.png]]