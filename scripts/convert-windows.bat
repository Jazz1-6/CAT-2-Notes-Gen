@echo off
REM Exam Notes Generator - Windows PDF conversion
REM Usage: convert-windows.bat <input.html> <output.pdf>

setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: convert-windows.bat input.html output.pdf
    exit /b 1
)
if "%~2"=="" (
    echo Usage: convert-windows.bat input.html output.pdf
    exit /b 1
)

set "INPUT=%~f1"
set "OUTPUT=%~f2"

REM Convert Windows backslashes to forward slashes for the file:// URL
set "INPUT_URL=!INPUT:\=/!"

REM Locate a headless browser (no unescaped parens inside if-blocks)
set "BROWSER="

if exist "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" set "BROWSER=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER if exist "C:\Program Files\Microsoft\Edge\Application\msedge.exe" set "BROWSER=C:\Program Files\Microsoft\Edge\Application\msedge.exe"
if not defined BROWSER if exist "C:\Program Files\Google\Chrome\Application\chrome.exe" set "BROWSER=C:\Program Files\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" set "BROWSER=C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
if not defined BROWSER if exist "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe" set "BROWSER=%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"

if not defined BROWSER (
    echo Error: No compatible browser found. Install Edge or Chrome.
    exit /b 1
)

echo Using: !BROWSER!
echo Input: !INPUT!
echo Output: !OUTPUT!
echo.

"!BROWSER!" --headless=new --disable-gpu --no-pdf-header-footer --print-to-pdf="!OUTPUT!" "file:///!INPUT_URL!"

if exist "!OUTPUT!" (
    echo.
    echo Output written to: !OUTPUT!
    endlocal
    exit /b 0
) else (
    echo.
    echo Error: PDF was not created.
    endlocal
    exit /b 1
)
