#!/bin/bash

# Instalar dependencias
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev

# Clonar repositorio
git clone --recurse-submodules https://github.com/fairyglade/ly

# Compilar ly
cd ly/
make
sudo make install installsystemd

# Activar ly en systemd
sudo systemctl enable ly.service

