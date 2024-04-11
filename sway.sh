#!/bin/bash

# Instalar Sway para Debian 12
sudo apt install -y sway

# Instalar programas adicionales
sudo apt install -y waybar tofi firefox-esr lf

# Descargar dotfiles de github
git clone https://github.com/mmgmp/dotfiles

# Colocar archivos config
mkdir -p ~/.config/sway
cp dotfiles/.config/sway/config ~/.config/sway/config

# Activar audio
sudo apt install -y wireplumber pipewire-pulse
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service
