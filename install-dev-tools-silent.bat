@echo off
title Silent Dev Tools Installer

:: Check if winget exists
where winget >nul 2>nul
if %errorlevel% neq 0 (
    exit /b 1
)

echo Installing Windows Terminal...
winget install --id Microsoft.WindowsTerminal -e ^
--accept-source-agreements --accept-package-agreements ^
--silent --disable-interactivity

echo Installing PowerShell 7...
winget install --id Microsoft.PowerShell -e ^
--accept-source-agreements --accept-package-agreements ^
--silent --disable-interactivity

echo Installing Git...
winget install --id Git.Git -e ^
--accept-source-agreements --accept-package-agreements ^
--silent --disable-interactivity

exit /b 0
