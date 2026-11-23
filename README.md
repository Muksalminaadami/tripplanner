# TripPlanner - Website Perencana Perjalanan Wisata (Laravel)

Project ini dibuat berdasarkan dokumen: UML Use Case Diagram, DFD Level 0,
Activity Diagram, dan ERD (Notasi Chen) untuk Website TripPlanner.

## ⚠️ PENTING - Baca dulu

File di folder ini **BUKAN** project Laravel yang utuh (folder `vendor/` dkk
di-generate otomatis oleh Composer), melainkan source code aplikasi yang
ditempelkan ke atas instalasi Laravel baru. Sudah termasuk `.env` siap pakai
dan `bootstrap/app.php` siap pakai supaya kamu **tidak perlu edit manual**.

## 🚫 Jangan pakai Laravel 10 / 11

Keduanya sudah **End of Life** (tidak dapat update keamanan), dan Composer
versi baru akan **menolak** menginstalnya. Gunakan **Laravel 12** atau
**Laravel 13** — kode di paket ini 100% kompatibel dengan keduanya.

## 🚀 Cara Menjalankan (Otomatis - disarankan)

### 1. Install Laravel baru di folder terpisah
Jangan jalankan di dalam folder hasil extract paket ini. Pindah ke folder
lain dulu (misal `C:\kuliah\RPL\`):

```powershell
php -v
# PHP 8.3+     -> composer create-project laravel/laravel tripplanner-app "^13.0"
# PHP 8.2      -> composer create-project laravel/laravel tripplanner-app "^12.0"
```

### 2. Buat database kosong
Buka phpMyAdmin (XAMPP/Laragon), buat database baru bernama **`tripplanner`**.
(Kalau nama user/password MySQL-mu bukan `root` tanpa password, edit dulu
bagian `DB_USERNAME` / `DB_PASSWORD` di file `.env` yang ada di paket ini,
**sebelum** menjalankan script di langkah 3.)

### 3. Jalankan `setup.ps1`
Buka `setup.ps1` di paket ini, cek/sesuaikan baris `$SourceDir` di bagian
atas (harus menunjuk ke folder hasil extract paket ini). Lalu, dari **dalam
folder `tripplanner-app`** (hasil langkah 1), jalankan:

```powershell
cd C:\kuliah\RPL\tripplanner-app
C:\kuliah\RPL\tripplanner-laravel-source\tripplanner\setup.ps1
```

Script ini otomatis: menyalin semua file aplikasi, `.env`, dan
`bootstrap/app.php` → menghapus migration bawaan Laravel yang bentrok →
migrate + seed data contoh → `storage:link`.

Kalau PowerShell menolak menjalankan script (`running scripts is disabled`),
jalankan dulu sekali ini (di PowerShell as Administrator):
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### 4. Jalankan server
```powershell
php artisan serve
```
Buka `http://127.0.0.1:8000`.

---

## 🛠️ Cara Manual (kalau tidak mau pakai script / pakai Mac/Linux)

1. Install Laravel baru (lihat langkah 1 di atas).
2. Salin & **timpa** ke folder `tripplanner-app`:
   ```
   app/Models/                                -> tripplanner-app/app/Models/
   app/Http/Controllers/                      -> tripplanner-app/app/Http/Controllers/
   app/Http/Middleware/AdminAuthenticate.php  -> tripplanner-app/app/Http/Middleware/
   database/seeders/                          -> tripplanner-app/database/seeders/
   resources/views/                           -> tripplanner-app/resources/views/
   routes/web.php                             -> tripplanner-app/routes/web.php
   config/auth.php                            -> tripplanner-app/config/auth.php
   bootstrap/app.php                          -> tripplanner-app/bootstrap/app.php
   .env                                       -> tripplanner-app/.env
   ```
3. **Hapus** 3 file migration bawaan ini dari `tripplanner-app/database/migrations/`
   (namanya diawali `0001_01_01_`) — karena bentrok dengan migration `users`
   milik TripPlanner, dan tidak kita pakai (`.env` sudah diset `SESSION_DRIVER=file`,
   `CACHE_STORE=file`, `QUEUE_CONNECTION=sync` supaya tabel sessions/cache/jobs
   tidak diperlukan):
   - `0001_01_01_000000_create_users_table.php`
   - `0001_01_01_000001_create_cache_table.php`
   - `0001_01_01_000002_create_jobs_table.php`
4. Salin semua isi `database/migrations/` dari paket ini ke
   `tripplanner-app/database/migrations/`.
5. Edit `.env` yang baru kamu salin: sesuaikan `DB_USERNAME`/`DB_PASSWORD`
   kalau MySQL-mu bukan default `root` tanpa password.
6. Jalankan (satu per satu, **jangan** pakai `&&` di PowerShell):
   ```powershell
   php artisan migrate:fresh --seed
   php artisan storage:link
   php artisan serve
   ```

## 🔑 Akun Default

**Admin** (`/admin/login`): `admin@tripplanner.com` / `admin123`
**User**: daftar sendiri lewat `/register`.

## 📝 Catatan

- Styling Bootstrap 5 via CDN — tidak perlu `npm install`/build.
- Peta lokasi pakai Google Maps Embed tanpa API key.
- `.env` yang disertakan pakai `APP_KEY` yang sudah di-generate — aman
  dipakai untuk tugas kuliah/lokal, tapi kalau mau deploy ke publik,
  generate ulang dengan `php artisan key:generate`.
- Kolom `updated_at` ditambahkan di semua tabel mengikuti konvensi Laravel,
  walau tidak digambarkan eksplisit di ERD.
