#!/bin/bash

# Instalar las dependencias
sudo apt install -y gcc clang libudev-dev libgbm-dev libxkbcommon-dev libegl1-mesa-dev libwayland-dev libinput-dev libdbus-1-dev libsystemd-dev libseat-dev libpipewire-0.3-dev libpango1.0-dev libdisplay-info-dev

# Instalar cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Descargar niri v25.11
wget https://github.com/YaLTeR/niri/archive/refs/tags/v25.11.zip

# Compilar niri
7z x v25.11.zip ; cd niri-25.11
cargo build --release

# Mover los archivos
sudo cp target/release/niri /usr/bin/
sudo cp resources/niri-session /usr/bin/
sudo cp resources/niri.desktop /usr/share/wayland-sessions/
sudo cp resources/niri-portals.conf /usr/share/xdg-desktop-portal/
sudo cp resources/niri.service /etc/systemd/user/
sudo cp resources/niri-shutdown.target /etc/systemd/user/

cd ..
