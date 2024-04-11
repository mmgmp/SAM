#!/bin/bash

# Instalar Sway para Debian 12
sudo apt install -y sway

# Instalar programas adicionales
sudo apt install -y waybar tofi firefox-esr lf

# Descargar dotfiles de github
git clone https://github.com/mmgmp/dotfiles

# Colocar archivos config
mkdir ~/.config/sway
cp dotfiles/sway/config ~/.config/sway/config
