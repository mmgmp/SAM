#!/bin/bash

# Instalar dependencias
sudo apt install -y Xwayland clang libxcb-cursor-dev libxcb1-dev

# Descvargar xwayland-satellite
wget https://github.com/Supreeeme/xwayland-satellite/archive/refs/tags/v0.8.zip

# Compilar xwayland-satellite
7z x v0.8.zip ; cd xwayland-satellite-0.8
cargo build --release -F systemd
