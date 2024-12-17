# Panduan Penggunaan Skrip `Mover.bat`

Skrip `Mover.bat` adalah skrip batch Windows yang digunakan untuk memindahkan file dan mengeluarkan file dari subfolder ke folder tujuan. Skrip ini memiliki dua fitur utama: pemindahan file ke folder dan pengeluaran file dari subfolder ke folder utama.

## Fitur Skrip

1. **Pemindahan File ke Folder**: Memindahkan file dengan ekstensi tertentu ke folder tujuan dengan pembatasan jumlah file per folder.
2. **Pengeluaran File dari Subfolder ke Folder**: Mengeluarkan file dari subfolder ke folder tujuan.

## Cara Menggunakan Skrip

### 1. Persiapan

Sebelum menjalankan skrip, pastikan Anda memiliki file `.bat` yang disalin ke dalam folder di komputer Anda.

### 2. Menjalankan Skrip

- Klik dua kali pada file `Mover.bat` untuk menjalankannya.
- Menu utama akan muncul seperti di bawah ini:

    ```
    =============================================================
            Skrip Pemindahan dan Pengeluar File by Roy1304
    =============================================================
    
    1. Pemindah File ke Folder
    2. Pengeluar File dari Subfolder ke Folder
    0. Keluar
    ```

### 3. Pilihan Menu

- **1. Pemindah File ke Folder**: Memindahkan file dengan ekstensi tertentu ke folder tujuan.
- **2. Pengeluar File dari Subfolder ke Folder**: Mengeluarkan file dari subfolder ke folder tujuan.
- **0. Keluar**: Menutup skrip.

### 4. Pemindahan File ke Folder

Jika Anda memilih **1. Pemindah File ke Folder**, langkah-langkah berikut akan dijalankan:

#### Input Folder Sumber

Anda akan diminta untuk memasukkan folder sumber tempat file yang ingin dipindahkan berada. Misalnya:
```js
Masukkan folder sumber (contoh: D:\MASTER\):
```

Pastikan folder tersebut ada di komputer Anda.

#### Input Ekstensi File

Anda akan diminta untuk memasukkan ekstensi file yang akan dipindahkan, misalnya `mp4`. Jika Anda tidak memasukkan apa pun, skrip akan menggunakan ekstensi default `mp4`.

#### Input Jumlah File per Folder

Masukkan jumlah file yang ingin dipindahkan ke setiap folder tujuan. Defaultnya adalah 20.

#### Input Folder Tujuan

Masukkan nama folder dasar tujuan. Jika kosong, skrip akan menggunakan nama folder sumber sebagai folder tujuan dasar.

#### Proses Pemindahan

Skrip akan memindahkan file sesuai dengan jumlah per folder yang telah ditentukan dan mencatat log dari setiap file yang berhasil dipindahkan. Jika ada file yang gagal dipindahkan, itu juga akan dicatat dalam log.

### 5. Pengeluaran File dari Subfolder ke Folder

Jika Anda memilih **2. Pengeluar File dari Subfolder ke Folder**, langkah-langkah berikut akan dijalankan:

#### Input Folder Sumber dan Tujuan

Anda akan diminta untuk memasukkan folder sumber yang berisi subfolder dan folder tujuan tempat file akan dikeluarkan.

#### Proses Pengeluaran

Skrip akan memindahkan file dari semua subfolder ke folder tujuan yang Anda pilih dan mencatat log pemindahan file.

#### Hapus Subfolder (Opsional)

Setelah file dipindahkan, skrip akan menanyakan apakah Anda ingin menghapus subfolder yang kosong. Jika memilih `Y`, subfolder kosong akan dihapus.

### 6. Log Aktivitas

Skrip ini juga mencatat setiap aktivitas pemindahan dalam file log (`TransferLog.txt`) di folder sumber. Log ini mencakup informasi seperti:
- File yang dipindahkan
- Waktu pemindahan
- Status keberhasilan atau kegagalan pemindahan

Contoh log:
```js
2024-12-17 12:34:56 - File "example.mp4" dipindahkan ke "D:\TargetFolder\1"
2024-12-17 12:35:00 - Gagal memindahkan file "example2.mp4"
```


### 7. Keluar dari Skrip

Untuk keluar dari skrip, pilih opsi **0. Keluar** pada menu utama.

---

## Contoh Alur Penggunaan Skrip

1. Jalankan skrip `Mover.bat`.
2. Pilih **1. Pemindah File ke Folder**.
3. Masukkan folder sumber, ekstensi file (misalnya `mp4`), dan jumlah file per folder (misalnya `20`).
4. Masukkan nama folder tujuan dasar (misalnya `bcl`).
5. Skrip akan mulai memindahkan file, menampilkan progress bar, dan mencatat log pemindahan.

---

## Troubleshooting

- **Folder Tidak Ditemukan**: Pastikan Anda memasukkan path folder dengan benar dan folder tersebut ada.
- **Gagal Memindahkan File**: Pastikan file tidak sedang digunakan oleh program lain dan pastikan Anda memiliki izin untuk memindahkan file ke folder tujuan.

---

Dengan mengikuti panduan ini, Anda dapat menggunakan skrip `Mover.bat` untuk memindahkan file dan mengeluar file dari subfolder ke folder tujuan dengan mudah.
