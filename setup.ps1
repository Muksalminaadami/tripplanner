# ============================================================
# setup.ps1 - Jalankan dari DALAM folder project Laravel baru
#              (hasil "composer create-project laravel/laravel tripplanner-app ...")
#
# Cara pakai:
#   1. Sesuaikan $SourceDir di bawah (lokasi folder hasil extract paket ini)
#   2. Buka PowerShell, masuk ke folder tripplanner-app
#   3. Jalankan: ..\path\ke\setup.ps1
# ============================================================

$SourceDir = "C:\kuliah\RPL\tripplanner-app"

if (-not (Test-Path ".\artisan")) {
    Write-Host "ERROR: Jalankan script ini dari DALAM folder project Laravel (yang ada file 'artisan')." -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $SourceDir)) {
    Write-Host "ERROR: Folder sumber tidak ditemukan: $SourceDir" -ForegroundColor Red
    Write-Host "Edit variabel `$SourceDir di bagian atas file setup.ps1 ini." -ForegroundColor Yellow
    exit 1
}

Write-Host "1. Menyalin file aplikasi..." -ForegroundColor Cyan
Copy-Item "$SourceDir\app\Models\*"                 ".\app\Models\" -Recurse -Force
Copy-Item "$SourceDir\app\Http\Controllers\*"       ".\app\Http\Controllers\" -Recurse -Force
Copy-Item "$SourceDir\app\Http\Middleware\AdminAuthenticate.php" ".\app\Http\Middleware\" -Force
Copy-Item "$SourceDir\database\seeders\*"           ".\database\seeders\" -Recurse -Force
Copy-Item "$SourceDir\resources\views\*"            ".\resources\views\" -Recurse -Force
Copy-Item "$SourceDir\routes\web.php"               ".\routes\web.php" -Force
Copy-Item "$SourceDir\config\auth.php"              ".\config\auth.php" -Force
Copy-Item "$SourceDir\bootstrap\app.php"            ".\bootstrap\app.php" -Force
Copy-Item "$SourceDir\.env"                         ".\.env" -Force

Write-Host "2. Menghapus migration bawaan Laravel yang bentrok (users/cache/jobs)..." -ForegroundColor Cyan
Get-ChildItem ".\database\migrations\" -Filter "0001_01_01_*" | Remove-Item -Force

Write-Host "3. Menyalin migration TripPlanner..." -ForegroundColor Cyan
Copy-Item "$SourceDir\database\migrations\*" ".\database\migrations\" -Recurse -Force

Write-Host "4. Menjalankan migrate + seed..." -ForegroundColor Cyan
php artisan migrate:fresh --seed

Write-Host "5. Membuat symlink storage..." -ForegroundColor Cyan
php artisan storage:link

Write-Host ""
Write-Host "SELESAI. Jalankan: php artisan serve" -ForegroundColor Green
