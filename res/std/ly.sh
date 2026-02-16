#!/bin/bash

red() {
    echo -e "\033[0;31m$1\033[0m"
}

# Comprobar si las herramientas están instaladas
[ -f /usr/bin/7z ] || sudo apt install -y p7zip-full

# Instalar dependencias
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev xauth xserver-xorg brightnessctl

# Descargar ziglang
wget https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz
7z x zig-x86_64-linux-0.15.2.tar.xz
7z x zig-x86_64-linux-0.15.2.tar

# Revisar ultima versión de Codeberg
LATEST_VERSION=$(curl -s https://codeberg.org/fairyglade/ly/releases/latest | grep -o 'v[0-9]\+\.[0-9]\+\.[0-9]\+' | head -n 1)

if [ -z "$LATEST_VERSION" ]; then
    red "Error al lograr la ultima versión de ly." && exit 1
fi

# Descargar ultima versión de ly
wget https://codeberg.org/fairyglade/ly/archive/$LATEST_VERSION.zip
7z x $LATEST_VERSION.zip && cd ly

# Compilar y activar servicio de systemd
sudo ../zig-x86_64-linux-0.15.2/zig build installexe 
sudo systemctl enable ly.service

sudo sed -i 's/clear_password = false/clear_password = true/' /etc/ly/config.ini
sudo sed -i 's/lang = en/lang = es/' /etc/ly/config.ini
sudo sed -i 's/numlock = false/numlock = true/' /etc/ly/config.ini

cd ..
