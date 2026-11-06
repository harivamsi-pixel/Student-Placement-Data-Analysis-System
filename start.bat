@echo off
echo ======================================================================
echo   Placement Cell Career Analytics System
echo   Tech Stack:
echo     - Frontend: HTML5, CSS3, JavaScript (Vanilla JS, Chart.js)
echo     - Backend:  Python 3, Flask REST API, Pandas, NumPy, Matplotlib
echo     - Database: MySQL 8 (with automatic SQLite fallback)
echo ======================================================================
echo.

echo [1/2] Checking Python environment...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python is not found in your PATH!
    echo Please install Python 3.10+ from python.org and ensure "Add Python to PATH" is checked.
    pause
    exit /b 1
)

echo [2/2] Starting Python Flask Application Server on Port 5000...
start "Placement System Server" cmd /k "cd /d %~dp0backend && python app.py"

echo.
echo Waiting for server to initialize on http://127.0.0.1:5000...
timeout /t 3 /nobreak >nul

echo Launching HTML/CSS/JS Portal in your default browser...
start http://localhost:5000

echo.
echo ======================================================================
echo   Placement Analytics Portal is now live:
echo   - Web Portal:          http://localhost:5000
echo   - Add / Edit Details:  http://localhost:5000 (Click "Add / Edit Details")
echo   - API Health:          http://localhost:5000/api/health
echo.
echo   NOTE ON COMPRESSING TO ZIP:
echo   - To zip the project in Windows Explorer, close the "Placement System Server"
echo     window first, OR simply double-click "create_zip.bat" anytime!
echo ======================================================================
echo.
pause
