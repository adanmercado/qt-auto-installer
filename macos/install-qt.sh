#!/bin/bash
# ******************************************************************************************
# *                    Author: Adán Mercado <adanmercado.dev@gmail.com>                    *
# *                    Github: https://github.com/adanmercado                              *
# ******************************************************************************************

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)

QT_INSTALLER_DOWNLOAD_URL="https://download.qt.io/official_releases/online_installers/qt-unified-mac-x64-online.dmg"
QT_INSTALLER_FILENAME=qt-installer.dmg
QT_TEMP_INSTALLATION_FOLDER_NAME=.qt-install

QT_INSTALL_SCRIPT_FILENAME=install.js
QT_INSTALL_SCRIPT_PATH=$SCRIPT_PATH/../js/$QT_INSTALL_SCRIPT_FILENAME

cd ~
if [[ -d "${QT_TEMP_INSTALLATION_FOLDER_NAME}" ]]
then
    rm -rf $QT_TEMP_INSTALLATION_FOLDER_NAME
fi

mkdir $QT_TEMP_INSTALLATION_FOLDER_NAME && cd $QT_TEMP_INSTALLATION_FOLDER_NAME

if [[ ! -f "${QT_INSTALLER_FILENAME}" ]]
then
    wget $QT_INSTALLER_DOWNLOAD_URL -O $QT_INSTALLER_FILENAME
fi

hdiutil attach $QT_INSTALLER_FILENAME

INSTALLER_NAME=$(ls /Volumes | grep "qt-unified-macOS")

cp $QT_INSTALL_SCRIPT_PATH ./$QT_INSTALL_SCRIPT_FILENAME

echo "" >> $QT_INSTALL_SCRIPT_FILENAME
cat $SCRIPT_PATH/../js/config.js >> $QT_INSTALL_SCRIPT_FILENAME
echo "" >> $QT_INSTALL_SCRIPT_FILENAME

/Volumes/$INSTALLER_NAME/$INSTALLER_NAME.app/Contents/MacOS/$INSTALLER_NAME \
    --verbose \
    --no-default-installations \
    --accept-messages \
    --script "$QT_INSTALL_SCRIPT_FILENAME"

hdiutil detach /Volumes/$INSTALLER_NAME

cd ~
rm -rf $QT_TEMP_INSTALLATION_FOLDER_NAME