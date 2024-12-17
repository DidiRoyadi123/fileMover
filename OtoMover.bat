@echo off
setlocal enabledelayedexpansion

:: Definisikan path hash file dan URL untuk buka otomatis
set "hash_file=%~dp0.hash"
set "target_url=https://www.kodekarir.com"

:: Fungsi untuk melakukan hash (SHA256) terhadap file skrip
set "hash="
for /f "delims=" %%a in ('certutil -hashfile "%~f0" SHA256 ^| findstr /v "certutil"') do (
    set "hash=%%a"
)

:: Cek apakah hash sudah ada dan cocok
if exist "%hash_file%" (
    set /p saved_hash=<"%hash_file%"
    if "%saved_hash%"=="%hash%" goto MENU
    echo File corrupt. Hash tidak cocok!
    pause
    exit
)

:: Jika hash tidak cocok atau belum ada, simpan hash file dan lanjutkan
echo %hash% > "%hash_file%"

:MENU
cls
echo ==========================================================================
echo     OtoMover Skrip Pemindahan dan Pengeluar File by kodekarir.com
echo ==========================================================================
echo.
echo 1. Pemindah File ke Folder
echo 2. Pengeluar File dari Subfolder ke Folder
echo 0. Keluar
echo.
set /p option=Masukkan pilihan (1/2/0): 

if "%option%"=="1" goto MoveFiles
if "%option%"=="2" goto RemoveFiles
if "%option%"=="0" exit
goto MENU

:MoveFiles
cls
echo =====================================================
echo        Skrip Pemindahan File by kodekarir.com        
echo =====================================================
echo.

:: Input folder sumber
set "source_folder="
set /p source_folder=Masukkan folder sumber (contoh: D:\folder2\folder1): 

if not exist "%source_folder%" (
    echo Folder sumber tidak ditemukan: %source_folder%
    pause
    goto MENU
)

:: Input ekstensi file (default MP4)
set "file_extension=mp4"
set /p file_extension_input=Masukkan ekstensi file (default mp4): 
if not "%file_extension_input%"=="" (
    set "file_extension=%file_extension_input%"
)

:: Menentukan path log file otomatis di folder sumber
set "log_file=%source_folder%\TransferLog.txt"

:: Input jumlah file per folder (default 20)
set "file_limit=20"
set /p file_limit_input=Masukkan jumlah file yang akan dipindahkan per folder (default 20): 
if not "%file_limit_input%"=="" (
    set "file_limit=%file_limit_input%"
)

:: Menghitung jumlah file dengan ekstensi yang dipilih di folder sumber
set /a total_files=0
for %%f in ("%source_folder%\*.%file_extension%") do (
    set /a total_files+=1
)

:: Menentukan angka folder akhir otomatis
set /a end_index=total_files / file_limit
if %end_index%==0 set /a end_index=1

:: Input folder tujuan dasar
set "base_target_folder="
set /p base_target_folder=Masukkan nama folder dasar tujuan (contoh: bcl): 

:: Jika folder tujuan kosong, buat otomatis berdasarkan nama folder awal
if "%base_target_folder%"=="" (
    echo Folder tujuan dasar tidak diisi, menggunakan nama folder sumber.
    set "base_target_folder=%source_folder%"
)

:: Pastikan file log ada
if not exist "%log_file%" (
    echo Log file tidak ditemukan, akan dibuat: %log_file%
    echo ====================== >> "%log_file%"
    echo Transfer Log dimulai pada %date% %time% >> "%log_file%"
    echo ====================== >> "%log_file%"
)

:: Konfirmasi pemindahan
echo ================================
echo Persiapan selesai. Berikut ini rincian:
echo.
echo Folder sumber: %source_folder%
echo Jumlah file yang akan dipindahkan: %total_files%
echo Jumlah file per folder: %file_limit%
echo Ekstensi file: %file_extension%
echo Folder tujuan dasar: %base_target_folder%
echo File log: %log_file%
echo ================================
set /p confirm=Apakah Anda ingin melanjutkan pemindahan file (Y/N)? 

if /i not "%confirm%"=="Y" (
    echo Pemindahan dibatalkan.
    pause
    goto MENU
)

:: Inisialisasi
set /a current_folder=1
set /a file_count=0
set /a processed_files=0

:: Loop melalui semua file dengan ekstensi yang ditentukan di folder sumber
for %%f in ("%source_folder%\*.%file_extension%") do (
    :: Jika folder tujuan penuh (sesuai jumlah file per folder), pindah ke folder berikutnya
    if !file_count! geq %file_limit% (
        set /a current_folder+=1
        set /a file_count=0
    )

    :: Tentukan folder tujuan
    set "target_folder=%source_folder%\%base_target_folder% (!current_folder!)"

    :: Buat folder jika belum ada
    if not exist "!target_folder!" (
        mkdir "!target_folder!"
    )

    :: Pindahkan file ke folder tujuan
    move "%%f" "!target_folder!" >nul
    if !errorlevel! equ 0 (
        echo %date% %time% - File "%%~nxf" dipindahkan ke "!target_folder!" >> "%log_file%"
        set /a file_count+=1
    ) else (
        echo %date% %time% - Gagal memindahkan file "%%~nxf" >> "%log_file%"
    )

    :: Update progress bar
    set /a processed_files+=1
    set /a progress=!processed_files!*100/%total_files%
    
    :: Tampilan progress bar
    set "bar="
    for /l %%i in (1,1,10) do (
        if %%i leq !progress!/10 (
            set "bar=!bar!#"
        ) else (
            set "bar=!bar! "
        )
    )

    echo Progress: [!bar!] !progress!%%

)

:: Cek apakah ada sisa file yang kurang dari file_limit
if !file_count! lss %file_limit% (
    echo Nama folder "%base_target_folder% (!current_folder!)" berisi !file_count! file.
    echo Sisa file yang tidak memenuhi jumlah per folder tetap dipindahkan.
)

echo ====================== >> "%log_file%"
echo Transfer selesai pada %date% %time% >> "%log_file%"
echo ====================== >> "%log_file%"

:: Buka otomatis URL setelah pemindahan selesai
start "" "%target_url%"

echo Pemindahan selesai. Lihat log di %log_file%.
pause
goto MENU

:RemoveFiles
cls
echo ==================================================================
echo        Skrip Pengeluar File dari Subfolder by kodekarir.com
echo ==================================================================
echo.

:: Input folder sumber untuk mengeluarkan file
set "source_folder="
set /p source_folder=Masukkan folder sumber (contoh: D:\folder): 

if not exist "%source_folder%" (
    echo Folder sumber tidak ditemukan: %source_folder%
    pause
    goto MENU
)

:: Input folder tujuan untuk mengeluarkan file
set "target_folder="
set /p target_folder=Masukkan folder tujuan untuk file yang dikeluarkan (contoh: D:\Backup): 

if not exist "%target_folder%" (
    echo Folder tujuan tidak ditemukan: %target_folder%
    pause
    goto MENU
)

:: Menghitung total file yang akan dikeluarkan
set /a total_files=0
for /r "%source_folder%" %%f in (*.mp4) do (
    set /a total_files+=1
)

:: Inisialisasi progress bar
set /a processed_files=0

:: Loop untuk mengeluarkan file dari subfolder ke folder tujuan
for /r "%source_folder%" %%f in (*.mp4) do (
    :: Pindahkan file ke folder tujuan
    move "%%f" "%target_folder%" >nul
    if !errorlevel! equ 0 (
        echo %date% %time% - File "%%~nxf" dikeluarkan dari "%%~dpf" ke "%target_folder%" >> "%log_file%"
    ) else (
        echo %date% %time% - Gagal mengeluarkan file "%%~nxf" >> "%log_file%"
    )

    :: Update progress bar
    set /a processed_files+=1
    set /a progress=!processed_files!*100/%total_files%
    
    :: Tampilan progress bar
    set "bar="
    for /l %%i in (1,1,10) do (
        if %%i leq !progress!/10 (
            set "bar=!bar!#"
        ) else (
            set "bar=!bar! "
        )
    )

    echo Progress: [!bar!] !progress!%%

)

:: Hapus subfolder jika dipilih
set "delete_subfolders=N"
set /p delete_subfolders_input=Apakah Anda ingin menghapus subfolder setelah file dipindahkan (Y/N)? 
if /i "%delete_subfolders_input%"=="Y" (
    set "delete_subfolders=Y"
)

:: Jika opsi hapus subfolder dipilih, hapus subfolder yang kosong
if "%delete_subfolders%"=="Y" (
    for /d %%d in ("%source_folder%\*") do (
        rd "%%d" 2>nul
        if !errorlevel! equ 0 (
            echo Subfolder "%%d" dihapus >> "%log_file%"
        )
    )
)

echo ====================== >> "%log_file%"
echo Pengeluaran file selesai pada %date% %time% >> "%log_file%"
echo ====================== >> "%log_file%"

:: Buka otomatis URL setelah pengeluaran selesai
start "" "%target_url%"

echo Pengeluaran file selesai. Lihat log di %log_file%.
pause
goto MENU
