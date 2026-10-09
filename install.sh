#!/bin/bash

clear
echo "=========================================================="
echo "                                                          "
echo "  Welcome to the Nature custom build.                "
echo "  Добро пожаловать в кастомную сборку Nature           "
echo "                                                          "
echo "  Base: Linux Mint (Xfce) + WhiteSur Dark Setup            "
echo "=========================================================="
echo " [EN] This script will remove LibreOffice and default      "
echo "      wallpapers, then install Firefox, Steam and themes. "
echo " -------------------------------------------------------- "
echo " [RU] Этот скрипт удалит LibreOffice и стандартные обои,  "
echo "      затем установит Firefox, Steam, темы и арт.         "
echo "=========================================================="
echo ""
read -p " Press [ENTER] to start installation / Нажмите [ENTER] для запуска... "

echo ""
echo "=========================================================="
echo " Processing installation... / Начинается установка...     "
echo "=========================================================="

# 1. Удаление ненужного софта (LibreOffice)
echo "--> Removing LibreOffice / Удаляем LibreOffice..."
sudo apt purge -y libreoffice*
sudo apt autoremove -y

# 2. Очистка стандартных обоев Linux Mint
echo "--> Cleaning default wallpapers / Удаляем стандартные обои..."
sudo rm -rf /usr/share/backgrounds/*

# 3. Обновление базы пакетов
echo "--> Updating package lists / Обновляем списки пакетов..."
sudo apt update

# 4. Установка нужных программ (Steam, Firefox, Neofetch)
echo "--> Installing Firefox, Steam & Neofetch / Устанавливаем софт..."
sudo apt install -y firefox steam neofetch git

# 5. Создание системных папок для тем и обоев
echo "--> Creating directories / Подготавливаем папки..."
mkdir -p ~/.themes
mkdir -p ~/.icons
mkdir -p ~/.config/neofetch
sudo mkdir -p /usr/share/backgrounds/custom-distro/

# 6. Копирование тем оформления и иконок
echo "--> Installing themes & icons / Устанавливаем темы WhiteSur и ReVista..."
cp -r WhiteSur-Dark* ~/.themes/ 2>/dev/null
cp -r ReVista* ~/.themes/ 2>/dev/null
cp -r WhiteSur-icon* ~/.icons/ 2>/dev/null
cp -r ReVista* ~/.icons/ 2>/dev/null

# 7. Копирование и автоматическая установка ваших обоев
echo "--> Applying custom wallpaper / Устанавливаем ваши обои..."
if [ -f "custom_wallpaper.jpg" ]; then
    sudo cp custom_wallpaper.jpg /usr/share/backgrounds/custom-distro/wallpaper.jpg
    
    # Команда для Xfce
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s /usr/share/backgrounds/custom-distro/wallpaper.jpg 2>/dev/null
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorXFCE_SCREEN_NUMBER/workspace0/last-image -s /usr/share/backgrounds/custom-distro/wallpaper.jpg 2>/dev/null
fi

# 8. Настройка Neofetch и кастомного ASCII-арта
echo "--> Configuring Neofetch / Настраиваем Neofetch..."
if [ -f "my_logo.txt" ]; then
    cp my_logo.txt ~/.config/neofetch/my_logo.txt
fi

# Добавление алиаса в .bashrc пользователя
if ! grep -q "neofetch --ascii" ~/.bashrc; then
    echo 'alias neofetch="neofetch --ascii ~/.config/neofetch/my_logo.txt"' >> ~/.bashrc
    echo 'neofetch' >> ~/.bashrc
    echo "--> Neofetch successfully configured! / Успешно настроено!"
fi

echo "=========================================================="
echo " Done! Please restart terminal. / Готово! Перезапустите терминал. "
echo "=========================================================="

