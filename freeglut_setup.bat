@echo off
title MSYS2 + FreeGLUT Auto Setup

echo ==========================================
echo Installing MSYS2 via Winget...
echo ==========================================
echo.

:: Install MSYS2 using winget
winget install -e --id MSYS2.MSYS2 --silent

if %errorlevel% neq 0 (
    echo MSYS2 installation failed.
    pause
    exit
)

echo.
echo ==========================================
echo Updating MSYS2...
echo ==========================================
echo.

C:\msys64\usr\bin\bash -lc "pacman -Sy --noconfirm"

echo.
echo ==========================================
echo Installing MinGW64 toolchain...
echo ==========================================
echo.

C:\msys64\usr\bin\bash -lc "pacman -S --noconfirm mingw-w64-x86_64-toolchain"

echo.
echo ==========================================
echo Installing FreeGLUT...
echo ==========================================
echo.

C:\msys64\usr\bin\bash -lc "pacman -S --noconfirm mingw-w64-x86_64-freeglut"

echo.
echo ==========================================
echo Adding MinGW64 to SYSTEM PATH...
echo ==========================================
echo.

setx /M PATH "%PATH%;C:\msys64\mingw64\bin"

echo.
echo ==========================================
echo Installation Complete!
echo ==========================================
echo.
echo Restart your PC or reopen terminal.
echo Compile using:
echo gcc main.c -o main.exe -lfreeglut -lopengl32 -lglu32
echo.
echo ==============================================
echo Installing Coderun package from GitHub
echo ==============================================
echo.

:: download Coderun from GitHub
echo Installing with pip…
python.exe -m pip install --upgrade pip
python -m pip install https://github.com/atif721/Coderun/archive/refs/heads/master.zip

echo.
echo Coderun installed!

pause