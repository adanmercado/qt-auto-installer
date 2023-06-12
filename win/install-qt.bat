@echo off
setlocal

rem ******************************************************************************************
rem *                    Author: Adán Mercado <adanmercado.dev@gmail.com>                    *
rem *                    Github: https://github.com/adanmercado                              *
rem ******************************************************************************************

set SCRIPT_PATH=%~dp0

set QT_INSTALLER_DOWNLOAD_URL="https://download.qt.io/official_releases/online_installers/qt-unified-windows-x64-online.exe"
set QT_INSTALLER_FILENAME=qt-installer.exe
set QT_TEMP_INSTALLATION_FOLDER_NAME=.qt-install

set QT_INSTALL_SCRIPT_FILENAME=install.js
set QT_INSTALL_SCRIPT_PATH="%SCRIPT_PATH%"\..\js\%QT_INSTALL_SCRIPT_FILENAME%

cd %userprofile%
if exist %QT_TEMP_INSTALLATION_FOLDER_NAME% rmdir /s /q %QT_TEMP_INSTALLATION_FOLDER_NAME%

mkdir %QT_TEMP_INSTALLATION_FOLDER_NAME%
cd %QT_TEMP_INSTALLATION_FOLDER_NAME%

if not exist "%QT_INSTALLER_FILENAME%" (
    curl %QT_INSTALLER_DOWNLOAD_URL% -o %QT_INSTALLER_FILENAME% --retry 5 --retry-delay 10 --max-time 180 -L
)%

copy %QT_INSTALL_SCRIPT_PATH% %QT_INSTALL_SCRIPT_FILENAME%

type "%SCRIPT_PATH%"\..\js\config.js >> %QT_INSTALL_SCRIPT_FILENAME%

%QT_INSTALLER_FILENAME% --verbose --no-default-installations --script "%QT_INSTALL_SCRIPT_FILENAME%"

cd %userprofile%
rmdir /s /q %QT_TEMP_INSTALLATION_FOLDER_NAME%

endlocal