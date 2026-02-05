@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:menu
cls
echo ======================================================
echo           ULTIMATE SERVER DIAGNOSTIC TOOL
echo ======================================================
echo 1 - Проверка ресурсов ПК (CPU, RAM, OS)
echo 2 - Глубокая проверка кода (JS/TS + C++)
echo 3 - Проверка окружения (Node, NPM, GCC)
echo 4 - Полный тест (Сборка + Запуск)
echo 5 - Выход
echo ======================================================
set /p choice="Выберите пункт (1-5): "

if "%choice%"=="1" goto check_pc
if "%choice%"=="2" goto check_code
if "%choice%"=="3" goto check_env
if "%choice%"=="4" goto full_test
if "%choice%"=="5" exit

:check_pc
cls
echo [1/3] Проверка CPU...
wmic cpu get name, numberofcores, maxclockspeed
echo [2/3] Проверка RAM...
systeminfo | findstr /C:"Total Physical Memory"
echo [3/3] Свободное место...
dir | find "bytes free"
pause
goto menu

:check_code
cls
echo [1/3] Проверка TypeScript (tsc)...
call npx tsc --noEmit
if %errorlevel% neq 0 (echo [!] Ошибки в TS коде!) else (echo [OK] TS в порядке.)

echo [2/3] Анализ C++ (linting simulation)...
findstr /s /n "TODO FIXME" src\native\*.*
echo [!] Проверьте логи выше на наличие недоделок.

echo [3/3] Валидация JSON файлов...
powershell -Command "Get-ChildItem -Filter *.json -Recurse | ForEach-Object { try { Get-Content $_.FullName | ConvertFrom-Json -ErrorAction Stop > $null; Write-Host '[OK]' $_.Name } catch { Write-Host '[FAIL]' $_.Name; exit 1 } }"
pause
goto menu

:check_env
cls
echo Node.js: && node -v
echo NPM: && npm -v
echo Проверка node-gyp...
call npx node-gyp --version
if %errorlevel% neq 0 (echo [!] node-gyp не найден!) 
pause
goto menu

:full_test
cls
echo Начинаю полную сборку...
call npm run build
if %errorlevel% equ 0 (
    echo [SUCCESS] Проект собран. Запускаю бенчмарк...
    node dist/server/app.js --test
) else (
    echo [ERROR] Сборка провалена. Ищите ошибку в C++ или TS.
)
pause
goto menu
