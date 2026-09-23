@echo off
REM Exam Notes Generator — Windows PDF conversion
REM Usage: convert-windows.bat <input.html> <output.pdf>

setlocal

if "%~1"=="" (
    echo Usage: convert-windows.bat input.html output.pdf
    exit /b 1
)
if "%~2"=="" (
    echo Usage: convert-windows.bat input.html output.pdf
    exit /b 1
)

set INPUT=%~f1
set OUTPUT=%~f2

REM Try Edge first (ships with Windows 10/11)
set EDGE1="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set EDGE2="C:\Program Files\Microsoft\Edge\Application\msedge.exe"

if exist %EDGE1% (
    echo Using Edge (x86 path)...
    %EDGE1% --headless=new --disable-gpu --print-to-pdf="%OUTPUT%" --no-pdf-header-footer "file:///%INPUT:\=/%"
    goto :done
)
if exist %EDGE2% (
    echo Using Edge (x64 path)...
    %EDGE2% --headless=new --disable-gpu --print-to-pdf="%OUTPUT%" --no-pdf-header-footer "file:///%INPUT:\=/%"
    goto :done
)

REM Fall back to Chrome
set CHROME="C:\Program Files\Google\Chrome\Application\chrome.exe"
if exist %CHROME% (
    echo Using Chrome...
    %CHROME% --headless=new --disable-gpu --print-to-pdf="%OUTPUT%" --no-pdf-header-footer "file:///%INPUT:\=/%"
    goto :done
)

echo Error: No compatible browser found (Edge or Chrome required).
exit /b 1

:done
echo.
echo Output written to: %OUTPUT%
endlocal