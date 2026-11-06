@echo off
setlocal
echo ======================================================================
echo   Placement Cell System - Project ZIP Archiver
echo ======================================================================
echo.

set "PROJECT_DIR=%~dp0"
set "ZIP_NAME=Placement_Cell_System_Backup.zip"
set "ZIP_PATH=%PROJECT_DIR%%ZIP_NAME%"

echo [1/2] Preparing clean project files...
if exist "%ZIP_PATH%" (
    echo Existing backup found. Removing old "%ZIP_NAME%"...
    del /f /q "%ZIP_PATH%"
)

echo [2/2] Compressing project directory into "%ZIP_NAME%"...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$dest = '%ZIP_PATH%';" ^
    "$source = '%PROJECT_DIR%';" ^
    "Add-Type -AssemblyName System.IO.Compression.FileSystem;" ^
    "$tempFolder = Join-Path ([System.IO.Path]::GetTempPath()) ([System.Guid]::NewGuid().ToString());" ^
    "New-Item -ItemType Directory -Path $tempFolder | Out-Null;" ^
    "Get-ChildItem -Path $source -Exclude '.git', '__pycache__', '*.zip', '*.tmp' | ForEach-Object {" ^
    "    Copy-Item -Path $_.FullName -Destination $tempFolder -Recurse -Force -ErrorAction SilentlyContinue" ^
    "};" ^
    "[System.IO.Compression.ZipFile]::CreateFromDirectory($tempFolder, $dest);" ^
    "Remove-Item -Path $tempFolder -Recurse -Force -ErrorAction SilentlyContinue;"

if exist "%ZIP_PATH%" (
    echo.
    echo ======================================================================
    echo   SUCCESS! ZIP created successfully:
    echo   File: %ZIP_PATH%
    echo ======================================================================
) else (
    echo.
    echo [ERROR] Failed to create ZIP file.
)

echo.
pause
