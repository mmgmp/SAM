#!/bin/bash

# Comprobar si las herramientas están instaladas
[ -f /usr/bin/7z ] || sudo apt install -y p7zip-full

# Instalar dependencias
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev xauth xserver-xorg brightnessctl

# Descargar ziglang
wget https://ziglang.org/download/0.15.2/zig-x86_64-linux-0.15.2.tar.xz
7z x zig-x86_64-linux-0.15.2.tar.xz
7z x zig-x86_64-linux-0.15.2.tar

# Descargar ly
wget https://codeberg.org/fairyglade/ly/archive/v1.2.0.zip
7z x v1.2.0.zip && cd ly

# Compilar y activar servicio de systemd
sudo ../zig-x86_64-linux-0.15.2/zig build installexe 
sudo systemctl enable ly.service

sudo sed -i 's/clear_password = false/clear_password = true/' /etc/ly/config.ini
sudo sed -i 's/lang = en/lang = es/' /etc/ly/config.ini
sudo sed -i 's/numlock = false/numlock = true/' /etc/ly/config.ini
sudo sed -i 's/session_log = ly-session.log/session_log = null/' /etc/ly/config.ini

cd ..
